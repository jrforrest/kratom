module Kratom
  require 'kratom/markdown_resource'

  class Note < MarkdownResource
    extension '.md'
  end
end
