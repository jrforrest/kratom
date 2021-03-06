require 'kratom/resource'
require 'sass'

module Kratom
  class Stylesheet < Resource
    input_extension 'sass'
    output_extension 'css'

    def output
      @output ||= with_tilt do |tilt|
        tilt.render(
          syntax: :sass,
          load_paths: config.paths.style_modules)
      end
    rescue Sass::SyntaxError => e
      raise Kratom::SyntaxError, "#{pathname}:#{e.sass_line}: #{e.message}"
    end
  end
end
