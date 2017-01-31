require 'pathname'
require 'kratom/exceptions'

module Kratom
  class ResourceCollection
    include Enumerable

    def initialize(site, resource_name, resource_class)
      @site, @resource_name, @resource_class =
        site, resource_name, resource_class
    end
    attr_reader :site, :resource_name, :resource_class

    def get(name)
      find {|p| p.name == name} ||
        raise(MissingResourceError,
          "No resource of type #{resource_class} with name: #{name}")
    end

    def each
      resources
    end

    private

    def resources
      @resources ||= Dir[input_pattern].map do |path|
        resource_class.new(site, Pathname.new(path))
      end
    end

    def input_pattern
      config.root.join(resource_path, '*', resource_class.extension)
    end

    def resource_path
      config.paths[resource_name.to_s]
    end

    def config
      site.config
    end
  end
end
