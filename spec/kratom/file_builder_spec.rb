require 'spec_helper'
require 'fileutils'
require 'pathname'

require 'kratom/file_builder'

describe Kratom::FileBuilder do
  let(:config) do
    double(:config,
      snippets_pattern: fixture('valid_site/snippets/*.md'),
      templates_pattern: fixture('valid_site/templates/*.md'),
      pages_pattern: fixture('valid_site/pages/*.md'),
      notes_pattern: fixture('valid_site/notes/*.md'),

      output_dir: out_dir,
      )

  end

  let(:out_dir) { Dir.mktmpdir }

  after(:each) { Dir.rmdir(tmpdir) }
end
