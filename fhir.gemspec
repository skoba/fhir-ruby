# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fhir/version'

Gem::Specification.new do |spec|
  spec.name          = "fhir"
  spec.version       = Fhir::VERSION
  spec.authors       = ["nicola"]
  spec.email         = ["niquola@gmail.com"]
  spec.description   = "fhir"
  spec.summary       = "fhir"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = 'fhir'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'i18n'
end
