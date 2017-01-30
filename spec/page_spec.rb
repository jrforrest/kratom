require 'spec_helper'
require 'page'

describe Page do
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
    expect(subject.html).to match /h1.*HelloWorld/
  end

  context 'with an invalid template file' do
    let(:file) { fixture('invalid-page.slim') }

    it 'raises a sensible error' do
      expect(subject.html).to raise_error(NoMethodError)
    end
  end
end
