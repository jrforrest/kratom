require 'spec_helper'
require 'kratom/note'

describe Kratom::Note do
  let(:pathname) { fixture('valid.md') }
  let(:config) { double('config') }
  let(:site) { site_double }
  let(:subject) { described_class.new(site, pathname) }

  it 'generates html' do
    expect(subject.output).not_to be_empty
  end

  it 'generates meta' do
    expect(subject.meta['name']).to eql('Valid Markdown')
  end

  shared_examples_for 'empty_meta' do
    it '#meta is empty' do
      expect(subject.meta.to_h).to be_empty
    end
  end

  context 'with empty meta' do
    let(:pathname) { fixture('no-meta.md') }

    it_behaves_like 'empty_meta'
  end

  context 'with no meta seperator' do
    let(:pathname) { fixture('no-sep.md') }
    it_behaves_like 'empty_meta'
  end

  context 'with the wrong meta type' do
    let(:pathname) { fixture('invalid.md') }

    it 'raises a parse error' do
      expect{subject.meta}.to raise_error(Kratom::MetaParseError)
    end
  end

  context 'with syntax error in the meta' do
    let(:pathname) { fixture('meta-syntax-error.md') }

    it 'raises a YAML parse error' do
      expect{subject.meta}.to raise_error(Kratom::MetaParseError)
    end
  end
end
