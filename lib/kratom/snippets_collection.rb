module Kratom
  require 'kratom/resource_collection'
  require 'kratom/snippet'

  class SnippetsCollection < ResourceCollection
    resource_class Snippet
  end
end
