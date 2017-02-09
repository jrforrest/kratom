module Kratom
  require 'kratom/resource'
  require 'slim'
  require 'tilt'

  class TemplateResource < Resource
    extension '.slim'

    def render(&block)
      if block
        with_tilt{|t| t.render(*render_args, &block) }
      else
        with_tilt{|t| t.render(*render_args) }
      end
    rescue Slim::Parser::SyntaxError => e
      raise Kratom::SyntaxError, "#{pathname}: #{e.message}"
    end

    private

    def render_args
      [nil, template_vars]
    end

    def template_vars
      { notes: site.notes,
        snippets: site.snippets,
        stylesheets: site.stylesheets}
    end

    def template
      @template ||= Tilt.new(pathname)
    end
  end
end
