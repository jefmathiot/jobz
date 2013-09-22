# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jobz/version'

Gem::Specification.new do |spec|
  spec.name          = "jobz"
  spec.version       = Jobz::VERSION
  spec.authors       = ["Jef Mathiot"]
  spec.email         = ["jeff.mathiot@gmail.com"]
  spec.description   = %q{A simple queuing system based on Resque & Resque-scheduler}
  spec.summary       = %q{A simple queuing system based on Resque & Resque-scheduler}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "mongoid", ">= 3.0.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "minitest", "~> 5.0.7"

  spec.add_dependency "activesupport", ">= 3.0.0"
  # Cannot move to 1.25.0 as resque-scheduler requires < 1.25
  # See https://rubygems.org/gems/resque-scheduler
  spec.add_dependency "resque", ">= 1.20.0"
  spec.add_dependency "resque-scheduler", "~> 2.1.0"
end
