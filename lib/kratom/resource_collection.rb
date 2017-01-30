require 'pathname'

class ResourceCollection
  class << self
    def resource_class(class_const)
      @resource_class = class_const if class_const
      @resource_class
    end
  end

  include Enumerable

  def initialize(site, input_pattern)
    @site, @input_pattern = site, input_pattern
  end

  attr_reader :site, :input_pattern, :resource_class

  def get(name)
    find {|p| p.name == name} ||
      raise MissingResourceError,
        "No resource of type #{resource_class} with name: #{name}"
  end

  def each
    resources
  end

  private

  def config
    site.config
  end

  def resources
    @resources ||= Dir[input_pattern].map do |path|
      resource_class.new(site, Pathname.new(path))
    end
  end

  def resource_class
    self.class.resource_class
  end
end
