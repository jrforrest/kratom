require 'spec_helper'
require 'kratom/stylesheet'
require 'ostruct'

describe Kratom::Stylesheet do
  let(:file) { fixture('valid_stylesheet.sass') }

  let(:config) do
    double(:config,
      stylesheet_syntax: 'sass',
      paths: OpenStruct.new(style_modules: 'blah'))
  end

  let(:site) { double(:site, config: config) }

  let(:stylesheet) { described_class.new(site, file) }

  let(:generated_css) do
    "body {\n"\
    "  margin: 0;\n"\
    "  padding: 0; }\n"\
    "\n"\
    "div {\n"\
    "  font-size: 8rem; }\n"
  end

  it 'generates css' do
    expect(stylesheet.output).to eql(generated_css)
  end

  context 'given an invalid spreadsheet' do
    let(:file) { fixture('invalid_stylesheet.sass') }

    it 'gets a little salty' do
      expect{stylesheet.output}.to raise_error(Kratom::SyntaxError)
    end
  end
end
