# coding: utf-8
# Ensure we require the local version and not one we might have installed already
#
require File.join([File.dirname(__FILE__),'lib','edld','version.rb'])

Gem::Specification.new do |spec|
  spec.name          = "edld"
  spec.version       = Edld::VERSION
  spec.authors       = ["Mick Pollard"]
  spec.email         = ["aussielunix@gmail.com"]
  spec.description   = %q{Daemon for logging CurrentCost envir data to a mysql db}
  spec.summary       = %q{CurrentCost Envir data logger}
  spec.homepage      = "http://aussielunix.github.io/edld/"
  spec.license       = "MIT"

  spec.files         = Dir['Gemfile', 'edld.gemspec', '{bin,lib,experiments}/**/**']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency('daemons')
  spec.add_dependency('yell')
  spec.add_dependency('serialport')
  spec.add_dependency('xml-simple')
  spec.add_dependency('mixlib-log')
  spec.add_dependency('mixlib-cli')
  spec.add_dependency('mixlib-config')
  spec.add_dependency('mixlib-shellout')
end
