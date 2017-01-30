require 'template_resource'

class Page < TemplateResource
  def html
    @html ||= layout.render { render }
  end

  private

  def layout
    site.templates.get(config.layout)
  end
end
