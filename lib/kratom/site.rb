require 'kratom/resource_collection'

require 'kratom/page'
require 'kratom/template'
require 'kratom/stylesheet'
require 'kratom/markdown_resource'
require 'kratom/note'

module Kratom
  class Site
    class ResourceType < Struct.new(:name, :resource_class)
      def buildable?
        not output_extension.nil?
      end

      def output_extension
        resource_class.output_extension
      end
    end

    class << self
      def resource_type(name, resource_class)
        define_method(name) do
          instance_variable_get("@#{name}") ||
            instance_variable_set("@#{name}",
              ResourceCollection.new(self, name, resource_class))
        end

        resource_types.push(ResourceType.new(name, resource_class))
      end

      def resource_types
        @resource_types ||= Array.new
      end
    end

    resource_type :stylesheets, Stylesheet
    resource_type :snippets, MarkdownResource
    resource_type :notes, Note
    resource_type :templates, Template
    resource_type :pages, Page

    def initialize(config)
      @config = config
    end

    attr_reader :config

    def resource_type(name)
      self.class.resource_types.find{|t| t.name == name} ||
        raise(ResourceTypeError, "Unknown resource type #{name}")
    end

    def resource_collection(name)
      type = resource_type(name)
      send(type.name)
    end
  end
end
