module Kratom
  require 'kratom/resource'
  require 'kramdown'

  class MarkdownResource < Resource
    SMART_QUOTES = %w{apos apos quot quot}

    def html
      @html ||= doc.to_html
    end

    private

    def doc
      Kramdown::Document.new(resource_text, smart_quotes: SMART_QUOTES)
    end
  end
end
