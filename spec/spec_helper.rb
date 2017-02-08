require 'pathname'

begin
  require 'pry'
rescue LoadError
end

$LOAD_PATH << Pathname.new(__dir__).join('../lib').to_s

module SpecHelpers
  def mock_config(params = {})
    double(:config).tap do |config|
      params.each do |key, value|
        allow(config).to recieve(key).and_return(value)
      end
    end
  end

  def output_dir
  end

  def fixture(name)
    fixture_path.join(name)
  end

  def fixture_path
    Pathname.new(__FILE__).dirname.join('fixtures')
  end

  def site_double
    @site_double ||= double(:site, config: double(:config))
  end
end

RSpec.configure do |config|
  config.include SpecHelpers

  config.before(:example) do
  end
end
