# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'azure/push/version'

Gem::Specification.new do |spec|
  spec.name          = "azure-push"
  spec.version       = Azure::Push::VERSION
  spec.authors       = ["Christian Sädtler"]
  spec.email         = ["christian@saedtler.net"]
  spec.summary       = %q{Gem for interacting with Azure notification hubs without using the azure-sdk}
  spec.homepage      = "https://github.com/christian-s/azure-push"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
