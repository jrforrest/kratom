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
      Kramdown::Document.new(md_text, smart_quotes: SMART_QUOTES)
    end

    def md_text
      file_content
    end
  end
end
