#!/usr/bin/env ruby

@root = Pathname.new(__dir__).join('..')

$LOAD_PATH << @root.join('lib')

require 'file_builder'
require 'main'
require 'rb-inotify'
require 'pathname'

def config
  @config ||= ComfyConf::Parser.new(@root.join('config.yml') do
    prop :site_name, type: String, required: true
    prop :output_dir, type: String, required: true
    propt :layout, type: String, required: true

    config :globs, required: true do
      prop :templates, required: true, type: String
      prop :pages, required: true, type: String
    end
  end.data
end

builder = FileBuilder.new(config)
builder.on_error do |error|
  STDERR.puts(error.message)
  exit 1
end

Main do
  mode 'build' do
    def run
      builder.build
    end
  end

  mode 'watch' do
    notifier = INotify::Notifier.new
    ['./pages/', './snippets/', './css/', './layouts/', './images'].each do |path|
      notifier.watch(path, :modify) do |ev|
        STDERR.puts 'Regenerating...'
        Generator.new(base_dir: base_dir).generate
      end
    end
    notifier.run
  end
end
