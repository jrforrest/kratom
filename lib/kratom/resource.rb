require 'kratom/exceptions'
require 'kratom/meta_data'
require 'tempfile'
require 'ostruct'
require 'yaml'
require 'tilt'

module Kratom
  class Resource
    Extensions = Struct.new(:input, :output)

    class << self
      def input_extension(given = nil)
        if given.nil?
          expect_set(:input_extension, @input_extension)
        else
          @input_extension = given
        end
      end

      def output_extension(given = nil)
        @output_extension = given if given
        @output_extension
      end

      private

      def expect_set(name, val)
        val || raise(ScriptError, "#{self} must have #{name} set!")
      end
    end

    def initialize(site, pathname)
      @site, @pathname = site, pathname
    end

    attr_reader :site, :pathname

    def name
      pathname.basename.sub_ext('').to_s
    end

    def meta
      @meta ||= MetaData.new((checked_meta_data || Hash.new).to_h, self)
    end

    def output
      raise NotImplementedError, "Each resource must implement output "\
        "with its own error handling."
    end

    def path
      if !self.class.output_extension.nil?
        Pathname.new "#{name}.#{self.class.output_extension}"
      else
        raise ResourceTypeError, "Resource type #{self.class} does not have "\
          "an output, and thus has no path."
      end
    end

    def type
      self.class.to_s
    end

    private

    def with_tilt
      with_tempfile {|path| yield Tilt.new(path) }
    end

    def with_tempfile
      file = Tempfile.new(['kratom', ".#{self.class.input_extension}"])
      file.write(resource_text)
      file.seek 0
      yield file.path
    ensure
      if file.kind_of?(File)
        file.close
        file.unlink
      end
    end

    def config
      site.config
    end

    def file_contents
      pathname.read
    rescue Errno::ENOENT => e
      raise FileError, e.message
    end

    def checked_meta_data
      if meta_data.kind_of?(Hash) or meta_data.kind_of?(FalseClass)
        meta_data
      else
        raise MetaParseError,
          "YAML meta data should be a hash. File: #{pathname}"
      end
    end

    def meta_data
      @meta_data ||= YAML.load(meta_text)
    rescue Psych::SyntaxError => e
      raise MetaParseError,
        "Markdown meta parse error in file #{pathname}: #{e.message}"
    end

    def meta_text
      if sep_index and sep_index > 0
        lines[0..(sep_index - 1)].join
      else
        ''
      end
    end

    def resource_text
      if sep_index
        lines[(sep_index + 1)..-1].join
      else
        lines.join
      end
    end

    def sep_index
      @sep_index ||= lines.index("---\n")
    end

    def lines
      @lines ||= file_contents.lines
    end
  end
end
