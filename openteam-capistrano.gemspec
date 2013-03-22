# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'openteam-capistrano'
  gem.version       = '0.0.1'
  gem.authors       = ["OpenTeam developers"]
  gem.email         = ["developers@openteam.ru"]
  gem.description   = %q{OpenTeam common capistrano recipe}
  gem.summary       = %q{Adds common use case tasks (import db, reload unicorn, send airbrake notice, tag deploy)}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano-db-tasks'
  gem.add_dependency 'capistrano-ext'
  gem.add_dependency 'capistrano-unicorn'
  gem.add_dependency 'rvm-capistrano'

  gem.add_development_dependency 'rake'
end
