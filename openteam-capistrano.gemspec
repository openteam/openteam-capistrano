# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openteam/capistrano/version'

Gem::Specification.new do |gem|
  gem.name          = "openteam-capistrano"
  gem.version       = Openteam::Capistrano::VERSION
  gem.authors       = ["Dmitry Lihachev"]
  gem.email         = ["lda@openteam.ru"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rvm-capistrano'
  gem.add_dependency 'capistrano-ext'
  gem.add_dependency 'capistrano-unicorn'
  gem.add_dependency 'capistrano-deploytags'
  gem.add_dependency 'capistrano-db-tasks'
  gem.add_dependency 'capistrano-git-plugins'
end
