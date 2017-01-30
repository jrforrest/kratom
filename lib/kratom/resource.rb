module Kratom
  class Resource
    Error = Class.new(StandardError)
    FileError = Class.new(Error)

    def initialize(site, pathname)
      @site, @pathname = site, pathname
    end
    attr_reader :site, :pathname

    def name
      pathname.sub_ext('')
    end

    private

    def config
      site.config
    end

    def file_contents
      pathname.read
    rescue Errno::ENOENT => e
      raise FileError, e.message
    end
  end
end
