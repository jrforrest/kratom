require 'kratom/exceptions'

module Kratom
  class MetaData
    def initialize(hash, resource)
      @hash, @resource = hash, resource
    end

    def [](key)
      hash[key.to_s] ||
        raise(MissingMetaData, "#{key} not found in #{resource.type} "\
          "#{resource.name} metadata.  Available keys "\
          "are: #{hash.keys.join(',')}")
    end

    def has_key?(key)
      hash.has_key?(key.to_s)
    end

    def empty?
      hash.empty?
    end

    private
    attr_reader :hash, :resource
  end
end
