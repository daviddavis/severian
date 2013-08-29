# -*- encoding: utf-8 -*-
require File.expand_path('../lib/severian/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Davis"]
  gem.email         = ["daviddavis@redhat.com"]
  gem.description   = %q{Gem for parsing rpm metadata}
  gem.summary       = %q{Parse that rpm metadata!}
  gem.homepage      = "http://www.katello.org"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "severian"
  gem.require_paths = ["lib"]
  gem.version       = Severian::VERSION

  gem.add_development_dependency "debugger"
end
