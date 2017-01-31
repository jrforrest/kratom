require 'kratom/site'
module Kratom
  # Builds a site using the given configuration
  class AbstractBuilder
    def initialize(config)
      @config = config
    end

    attr_reader :config

    def site
      @site ||= Site.new(config)
    end

    def build
      raise NotImplementedError
    end
  end
end
