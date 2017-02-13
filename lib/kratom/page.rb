require 'kratom/layout_embedded'
require 'kratom/template_resource'

module Kratom

  class Page < TemplateResource
    input_extension 'slim'
    output_extension 'html'

    include LayoutEmbedded

    def output
      @output ||= render_with_layout
    rescue Slim::Parser::SyntaxError => e
      raise Kratom::SyntaxError, "#{pathname}: #{e.message}"
    rescue ::NameError => e
      raise Kratom::NameError, "#{pathname}: #{e.message}"
    end
  end
end
