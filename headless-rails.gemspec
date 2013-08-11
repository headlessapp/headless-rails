# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'headless/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "headless-rails"
  spec.version       = Headless::Rails::VERSION
  spec.authors       = ["Matthew Rudy Jacobs"]
  spec.email         = ["MatthewRudyJacobs@gmail.com"]
  spec.summary       = %q{ API wrapper for the HeadlessApp.com }
  spec.description   = %q{ Seamlessly integrate headlessapp.com into your Rails application }

  spec.homepage      = "http://www.headlessapp.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.6.7"
  spec.add_dependency "json"
  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
