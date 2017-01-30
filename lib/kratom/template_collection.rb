module Kratom
  require 'template'

  class TemplateCollection < ResourceCollection
    resource_class Template

    def initialize(site)
      super(site, site.config.templates_pattern, Template)
    end
  end
end
