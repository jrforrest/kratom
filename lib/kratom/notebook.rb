require 'pathname'

class Notebook
  attr_reader :config

  def initialize(config: config)
    @config = config
  end

  def process
    files.each do |pathname|
      resource(pathmame).write
      output_pathname(pathname).write(resource(pathname).html)
    end
  end

  private

  def resource(pathname)
    Note.new(pathname, config: config)
  end

  def output_pathname(input_pathname)
    name = input_pathname.sub_ext('')
    config.output_dir.join("#{name}.html")
  end

  def files
    Dir[config.join('*.md')].map {|path| Pathname.new(path)}
  end
end
