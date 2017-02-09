require 'spec_helper'
require 'kratom/page'

describe Kratom::Page do
  let(:notes) { double(:notes) }

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
      notes: notes,
      snippets: [],
      stylesheets: [])
  end

  subject { described_class.new(site, file) }

  it 'generates html' do
    expect(subject.output).to match '<h1>Hello World!</h1>'
  end

  describe '#name' do
    it 'returns the name of the page' do
      expect(subject.name).to eql('valid-page')
    end
  end

  context 'with an invalid template file' do
    let(:file) { fixture('invalid-page.slim') }

    it 'raises a sensible error' do
      expect{subject.output}.to raise_error(Kratom::SyntaxError)
    end
  end

  context 'with invalid variable references in the template' do
    let(:file) { fixture('missing-vars.slim') }

    it 'raises a sensible error' do
      expect{subject.output}.to raise_error(Kratom::NameError)
    end
  end

  context 'with notes in the page' do
    let(:file) { fixture('page-with-notes.slim') }

    let(:notes) do
      note = double(:note, title: 'Woah a note!')
      double(:notes, get: note)
    end

    it 'includes the note' do
      expect(subject.output).to match(/Woah a note/)
    end
  end

  context 'with a lil\' meta' do
    let(:file) { fixture('meta-page.slim') }

    it 'has meta' do
      expect(subject.meta.so).to eql('meta')
    end
  end

  context 'with layout meta' do
    let(:file) { fixture('meta-layout-page.slim') }

    it 'renders with the appropriate layout' do
      expect(site_templates).to receive(:get).with('blah')
      subject.output
    end
  end
end
