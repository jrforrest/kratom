module Kratom
  require 'kratom/markdown_resource'

  class Note < MarkdownResource
    input_extension 'md'
    output_extension 'html'
  end
end
