# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ruby_macros/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joel McCracken"]
  gem.email         = ["mccracken.joel@gmail.com"]
  gem.description   = %q{ Macro support in Ruby }
  gem.summary       = %q{ Macro support in Ruby }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ruby_macros"
  gem.require_paths = ["lib"]
  gem.version       = RubyMacros::VERSION
end
