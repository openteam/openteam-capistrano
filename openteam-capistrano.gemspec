# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'openteam-capistrano'
  gem.version       = '1.0.18'
  gem.authors       = ['OpenTeam developers']
  gem.email         = ['developers@openteam.ru']
  gem.description   = 'OpenTeam common capistrano3 recipe'
  gem.summary       = 'Adds common use case tasks (import db, reload unicorn, send airbrake notice, tag deploy)'
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'airbrake' # ,            '~> 3.1.16'
  gem.add_dependency 'capistrano', '~> 3.5'
  gem.add_dependency 'capistrano-db-tasks' # , '~> 0.3'
  gem.add_dependency 'capistrano-rails' # ,    '~> 1.1'
  gem.add_dependency 'capistrano-faster-assets' # ,    '~> 1.0'
  gem.add_dependency 'capistrano-rvm'
  gem.add_dependency 'capistrano-sidekiq'
  gem.add_dependency 'capistrano3-unicorn'
  gem.add_dependency 'slackistrano' # , '~> 3.1.0'

  gem.add_development_dependency 'rake'
end
