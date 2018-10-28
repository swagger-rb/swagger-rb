lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swagger/version'

Gem::Specification.new do |spec|
  spec.name          = 'swagger-core'
  spec.version       = Swagger::VERSION
  spec.authors       = ['Max Lincoln']
  spec.email         = ['max@devopsy.com']
  spec.summary       = 'Swagger parser for Ruby'
  spec.description   = <<-eos
    The Swagger gem parses and provides an simple API for
    [Swagger](http://swagger.io/) documents that define RESTful APIs.
  eos
  spec.homepage      = 'https://github.com/maxlinc/swagger-rb'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'addressable', '~> 2.3'
  spec.add_dependency 'hashie', '~> 3.0', '< 3.4.0'
  spec.add_dependency 'json-schema', '~> 2.2'
  spec.add_dependency 'mime-types'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop', '0.47.1'
  spec.add_development_dependency 'rake-notes'
  spec.add_development_dependency 'inch'
end
