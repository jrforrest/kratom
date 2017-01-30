require 'resource'
require 'slim'
require 'tilt'

class TemplateResource < Resource
  SyntaxError = Class.new(Error)

  def render(&block)
    if block
      template.render(*render_args, block)
    else
      template.render(*render_args)
    end
  rescue Slim::Parser::SyntaxError => e
    raise SyntaxError, "#{pathname}: #{e.message}"
  end

  private

  def render_args
    [nil, template_vars]
  end

  def template_vars
    { snippets: site.snippets,
      stylesheets: site.stylesheets}
  end

  def template
    @template ||= Tilt.new(pathname)
  end
end
