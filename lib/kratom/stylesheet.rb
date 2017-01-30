module Kratom
  class Stylesheet < Resource
    SyntaxError = Class.new(Error)

    def generate
      output_pathname.write(css)
    end

    private

    def output_pathname
      config.output_dir.join("#{name}.css")
    end

    def css
      @css ||= engine.render()
    rescue Sass::SyntaxError => e
      raise SyntaxError, "#{pathname}: #{e.message}"
    end

    def engine
      Sass::Engine.new(
        file_contents,
        syntax: site.config.stylesheet_syntax,
        load_paths: site.config.stylesheet_load_path)
    end
  end
end
