require 'kratom/resource'
require 'sass'

module Kratom
  class Stylesheet < Resource

    def css
      @css ||= engine.render()
    rescue Sass::SyntaxError => e
      raise Kratom::SyntaxError, "#{pathname}:#{e.sass_line}: #{e.message}"
    end

    private

    def output_pathname
      config.output_dir.join("#{name}.css")
    end

    def engine
      Sass::Engine.new(
        file_contents,
        syntax: site.config.stylesheet_syntax,
        load_paths: site.config.stylesheet_load_path)
    end
  end
end
