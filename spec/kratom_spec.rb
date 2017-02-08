require 'spec_helper'

require 'fileutils'

describe 'The Kratom CLI' do
  let(:kratom_path) { Pathname.new(__dir__).join('..', 'bin', 'kratom') }

  before(:all) do
    @runtime_directory = Dir.pwd
    Dir.chdir fixture('valid_site')
  end

  after(:each) { FileUtils.rm_rf output_dir.join('*')}

  after(:all) { Dir.chdir(@runtime_directory) }

  let(:output_dir) { fixture('valid_site').join('out') }

  context 'when generating a site' do
    it 'creates output files' do
      expect(Kernel.system(kratom_path.to_s, 'build')).to eql(true)
      expect(output_dir.join('home.html')).to be_file
    end
  end
end
