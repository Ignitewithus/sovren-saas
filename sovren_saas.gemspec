# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sovren_saas/version'

Gem::Specification.new do |spec|
  spec.name          = "sovren_saas"
  spec.version       = SovrenSaas::VERSION
  spec.authors       = ["Mark Montroy"]
  spec.email         = ["mark@ignitewithus.com"]
  spec.description   = "This is a gem used for parsing resumes using the Sovren Saas resume parser service. Based off the standalone Sovren gem by Eric Flemming"
  spec.summary       = "This is a gem used for parsing resumes using the Sovren Saas resume parser service. Based off the standalone Sovren gem by Eric Flemming"
  spec.homepage      = "http://github.com/ignitewithus/sovren-saas"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.2'

  spec.add_dependency "savon", "~> 2.3.0"
  spec.add_dependency "httpclient", "~> 2.3.3"
  spec.add_dependency "nokogiri", "~> 1.5.9"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", '< 1.10'
  spec.add_development_dependency "simplecov"

  spec.requirements << "Access to a sovren_saas resume parser server."
end
