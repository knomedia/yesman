# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yesman/version'

Gem::Specification.new do |gem|
  gem.name          = "yesman"
  gem.version       = Yesman::VERSION
  gem.authors       = ["Jason Madsen"]
  gem.email         = ["knomedia@gmail.com"]
  gem.description   = %q{CLI for quick creation of C++ projects using GTest}
  gem.summary       = %q{Yesman creates project directory structures, downloads and builds GTest for C++ development projects}
  gem.homepage      = ""

  gem.add_dependency 'mixlib-cli', '~> 1.2.2'
  gem.add_dependency 'paint', '~> 0.8.5'
  gem.add_dependency 'versionomy', '~> 0.4.4'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
