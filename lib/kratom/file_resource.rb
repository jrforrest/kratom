module Kratom
  class FileResource
    MissingFile = Class.new(StandardError)

    attr_reader :pathname, :config

    def initialize(pathname, config:)
      @pathname, @config = pathname, config
    end

    def contents
      pathname.read
    end

    def name
      pathname.sub_ext('').to_s
    end
  end
end
