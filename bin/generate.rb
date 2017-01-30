#!/usr/bin/env ruby
# Generates static site from current dir into ./dist

require 'rb-inotify'
require 'yaml'

Slim::Engine.set_options(pretty: true)

$LOAD_PATH << File.join(__dir__, '../lib')
require 'generator'

base_dir = File.join(__dir__, '../')

if $PROGRAM_NAME == __FILE__
  if ARGV.first == 'watch'
    STDERR.puts 'Watching all files in ./'
    notifier = INotify::Notifier.new
    ['./pages/', './snippets/', './css/', './layouts/', './images'].each do |path|
      notifier.watch(path, :modify) do |ev|
        STDERR.puts 'Regenerating...'
        Generator.new(base_dir: base_dir).generate
      end
    end
    notifier.run
  else
    Generator.new(base_dir: base_dir).generate
  end
end
