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

  let(:root_dir) { fixture('valid_site') }
  let(:output_dir) { root_dir.join('out') }

  context 'when generating a site' do
    it 'creates output files' do
      expect(run_build).to eql(true)
      expect(output_dir.join('home.html')).to be_file
    end
  end

  context 'when watching the build directory' do
    let(:home_file) { root_dir.join('pages', 'home.slim') }
    let!(:home_content) { home_file.read }
    let(:home_out_file) { output_dir.join('home.html') }

    let!(:before_ts) do
      run_build
      File.mtime(home_out_file)
    end

    before do
      @pid = Kernel.spawn(kratom_path.to_s, 'watch')
      sleep 4
    end

    after { Process.kill("INT", @pid) }

    it 'rebuilds whenever the input files are written' do
      home_file.write(home_content)
      sleep 2
      expect(File.mtime(home_out_file)).to be > before_ts
    end
  end

  private

  def run_build
    Kernel.system(kratom_path.to_s, 'build')
  end
end
