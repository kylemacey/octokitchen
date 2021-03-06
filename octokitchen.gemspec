# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octokitchen/version'

Gem::Specification.new do |spec|
  spec.name          = "octokitchen"
  spec.version       = Octokitchen::VERSION
  spec.authors       = ["Kyle Macey"]
  spec.email         = ["kylemacey@github.com"]

  spec.summary       = %q{A utility to help write scripts for GitHub}
  spec.description   = %q{A utility to help write scripts for GitHub}
  spec.homepage      = "https://github.com/kylemacey/octokitchen"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["octokitchen"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "octokit", "~> 4.0"
  spec.add_dependency "thor", "~> 0.19.1"
end
