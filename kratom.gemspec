# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kratom/version'

Gem::Specification.new do |spec|
  spec.name          = "kratom"
  spec.version       = Kratom::VERSION
  spec.authors       = ["Jack Forrest"]
  spec.email         = ["jack@jrforrest.net"]

  spec.summary       = "A little static site generator"
  spec.description   = "Kratom is a static site generator for creating "\
                       "professional portfolio sites."
  spec.homepage      = "github.com/jrforrest/kratom"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_dependency "slim", "~> 3.0"
  spec.add_dependency "sass", "~> 3.0"
  spec.add_dependency "tilt", "~> 2.0"
  spec.add_dependency "kramdown", "~> 1.9"
  spec.add_dependency "inotify", "~> 1.0"
  spec.add_dependency "main", "~> 6.2"
  spec.add_dependency "pastel", "~> 0.7"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
