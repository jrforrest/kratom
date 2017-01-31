module Kratom
  require 'kratom/generatable_resource_collection'
  require 'kratom/page'

  class PageCollection < GeneratableResourceCollection
    resource_class Page
  end
end
