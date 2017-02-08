require 'kratom/abstract_builder'
require 'fileutils'


module Kratom
  class FileBuilder < AbstractBuilder
    ResourceType = Struct.new(:collection, :ext)

    def build
      build_directories
      resource_types.each { |type| build_type(type) }
    end

    private

    def build_directories
      FileUtils.mkdir_p(config.output_dir)
    end

    def resource_types
      [ [site.pages, 'html'],
        [site.notes, 'html'],
        [site.stylesheets, 'css']
      ].map {|a| ResourceType.new(*a) }
    end

    def build_type(resource_type)
      resource_type.collection.each do |resource|
        content = resource.output
        write_output_file(resource.name, resource_type.ext, content)
      end
    end

    def write_output_file(name, extension, content)
      output_dir.join("#{name}.#{extension}").write(content)
    end

    def output_dir
      Pathname.new(config.output_dir)
    end
  end
end
