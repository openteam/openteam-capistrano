require 'capistrano/ext/multistage'

require 'bundler/capistrano'
require 'rvm/capistrano'

require 'capistrano-db-tasks' if use_db?
require 'capistrano-unicorn'
begin; require 'airbrake/capistrano'; rescue LoadError; end

