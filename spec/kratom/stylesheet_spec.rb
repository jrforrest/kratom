require 'spec_helper'
require 'kratom/stylesheet'

describe Kratom::Stylesheet do
  let(:file) { fixture('valid_stylesheet.sass') }

  let(:config) do
    double(:config,
      stylesheet_syntax: 'sass',
      stylesheet_load_path: [fixture_path.to_s])
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
    expect(stylesheet.css).to eql(generated_css)
  end

  context 'given an invalid spreadsheet' do
    let(:file) { fixture('invalid_stylesheet.sass') }

    it 'gets a little salty' do
      expect{stylesheet.css}.to raise_error(Kratom::SyntaxError)
    end
  end
end
