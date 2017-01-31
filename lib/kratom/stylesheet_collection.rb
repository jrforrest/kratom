module Kratom
  require 'kratom/generatable_resource_collection'
  require 'kratom/stylesheet'

  class StylesheetCollection < ResourceCollection
    resource_class Stylesheet
  end
end
