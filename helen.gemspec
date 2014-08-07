# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'helen/version'

Gem::Specification.new do |spec|
  spec.name          = "helen"
  spec.version       = Helen::VERSION
  spec.authors       = ["Juan Pemberthy"]
  spec.email         = ["jpemberthy@gmail.com"]
  spec.summary       = "Gem to manipulate Titan graphs through Rexster."
  spec.description   = "Gem to manipulate Titan graphs through Rexster."
  spec.homepage      = "https://github.com/jpemberthy/helen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
end
