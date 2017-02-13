module Kratom
  module LayoutEmbedded
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
      meta.has_key?(:layout) ? meta[:layout] : 'default'
    end
  end
end
