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

    def each(&b)
      resources.each(&b)
    end

    private

    def resources
      @resources ||= input_paths.map do |path|
        resource_class.new(site, path)
      end
    end

    def input_paths
      Dir[input_pattern].map {|p| Pathname.new(p)}
    end

    def input_pattern
      resource_path.join("*#{resource_class.extension}")
    end

    def resource_path
      config.paths.send(resource_name.to_s)
    end

    def config
      site.config
    end
  end
end
