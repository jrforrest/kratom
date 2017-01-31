require 'spec_helper'
require 'kratom/page'

describe Kratom::Page do
  let(:layout) do
    double(:layout).tap do |layout|
      allow(layout).to receive(:render).and_yield
    end
  end

  let(:site_templates) do
    double(:site_templates, get: layout)
  end

  let(:config) do
    double(:config, layout: 'default')
  end

  let(:file) { fixture('valid-page.slim') }

  let(:site) do
    double(:site,
      config: config,
      templates: site_templates,
      snippets: [],
      stylesheets: [])
  end
  subject { described_class.new(site, file) }

  it 'generates html' do
    expect(subject.output).to match '<h1>Hello World!</h1>'
  end

  context 'with an invalid template file' do
    let(:file) { fixture('invalid-page.slim') }

    it 'raises a sensible error' do
      expect{subject.output}.to raise_error(Kratom::SyntaxError)
    end
  end

  context 'with a lil\' meta' do
    let(:file) { fixture('meta-page.slim') }

    it 'has meta' do
      expect(subject.meta.so).to eql('meta')
    end
  end
end
