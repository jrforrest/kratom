require 'kratom/resource_collection'

require 'kratom/page'
require 'kratom/template'
require 'kratom/stylesheet'
require 'kratom/markdown_resource'
require 'kratom/note'

module Kratom
  class Site
    class << self
      def resource_type(name, resource_class)
        define_method(name) do
          instance_variable_get("@#{name}") ||
            instance_variable_set("@#{name}",
              ResourceCollection.new(self, name, resource_class))
        end
      end
    end

    resource_type :pages, Page
    resource_type :templates, Template
    resource_type :stylesheets, Stylesheet
    resource_type :snippets, MarkdownResource
    resource_type :notes, Note

    def initialize(config)
      @config = config
    end

    attr_reader :config
  end
end
