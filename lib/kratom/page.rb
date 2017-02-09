module Kratom
  require 'kratom/template_resource'

  class Page < TemplateResource
    extension '.slim'

    def output
      @output ||= render_with_layout
    rescue Slim::Parser::SyntaxError => e
      raise Kratom::SyntaxError, "#{pathname}: #{e.message}"
    rescue ::NameError => e
      raise Kratom::NameError, "#{pathname}: #{e.message}"
    end

    private

    def render_with_layout
      layout.render { render }
    end

    def layout
      site.templates.get(layout_name)
    rescue MissingResourceError => e
      raise MissingResourceError, missing_layout_message(layout_name)
    end

    def missing_layout_message(layout_name)
      "Error rendering #{name}: \n" +
        if layout_name == 'default'
          "No default template is specified!  Create a new template "\
          "called default in #{config.paths.templates}."
        else
          "No layout with name #{layout_name} found "\
          "in #{config.paths.templates}."
        end
    end

    def layout_name
      meta['layout'] || 'default'
    end
  end
end
