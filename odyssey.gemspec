# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "odyssey/version"


Gem::Specification.new do |gem|
  gem.name          = "odyssey"
  gem.version       = Odyssey::VERSION
  gem.authors       = ["Joel McCracken"]
  gem.email         = ["mccracken.joel@gmail.com"]
  gem.description   = %q{ Macro support in Ruby }
  gem.summary       = %q{ Macro support in Ruby }
  gem.homepage      = "http://github.com/joelmccracken/odyssey"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "minitest"

  # external parsers that are / may be used
  gem.add_development_dependency "ruby_parser"
  gem.add_development_dependency "melbourne"
end
