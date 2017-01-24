# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matron/version'

Gem::Specification.new do |spec|
  spec.name          = "matron"
  spec.version       = Matron::VERSION
  spec.authors       = ["Misha Conway"]
  spec.email         = ["mishaAconway@gmail.com"]

  spec.summary       = "Watches long running sql queries and does not tolerate bad behavior."
  spec.description   = "Watches long running sql queries and does not tolerate bad behavior."
  spec.homepage      = "https://github.com/MishaConway/matron"
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'matron-client', '0.1.0'
  spec.add_runtime_dependency 'sequel', "~> 4.42.1"
  spec.add_runtime_dependency 'mysql2'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
