require 'spec_helper'
require 'fileutils'
require 'pathname'

require 'kratom/file_builder'

describe Kratom::FileBuilder do
  let(:config) do
    OpenStruct.new(
      root: input_dir,
      paths: OpenStruct.new(
        style_modules: input_dir.join('style_modules'),
        stylesheets: input_dir.join('stylesheets'),
        templates: input_dir.join('templates'),
        pages: input_dir.join('pages'),
        notes: input_dir.join('notes'),
      ),
      output_dir: out_dir
    )
  end

  let(:out_dir) { Pathname.new(Dir.mktmpdir("kratom-spec")) }

  after(:each) { FileUtils.rm_rf(out_dir) }

  let(:subject) { described_class.new(config) }

  context 'when the site is valid' do
    let(:input_dir) { fixture('valid_site') }

    before { subject.build }

    it 'builds the homepage' do
      expect(out_dir.join('home.html')).to be_file
    end

    it 'builds stylesheets' do
      expect(out_dir.join('style.css')).to be_file
    end
  end

  context 'when there\'s a file conflict' do
    let(:input_dir) { fixture('file_conflict_site') }

    it 'Errors out on the conflict' do
      expect{subject.build}.to raise_error(Kratom::ResourceConflict)
    end
  end
end
