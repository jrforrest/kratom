module Kratom
  require 'kratom/resource'

  class MarkdownResource < Resource
    SMART_QUOTES = %w{apos apos quot quot}

    def output
      @output ||= with_tilt {|t| t.render }
    end
  end
end
