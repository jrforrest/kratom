require 'kratom/markdown_resource'
require 'kratom/layout_embedded'

module Kratom

  class Note < MarkdownResource
    input_extension 'md'
    output_extension 'html'

    include LayoutEmbedded

    def output
      @output ||= render_with_layout
    end
  end
end
