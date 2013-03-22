require 'capistrano/ext/multistage'

require 'bundler/capistrano'
require 'rvm/capistrano'

#require 'capistrano-deploytags'
require 'capistrano-db-tasks'
require 'capistrano-unicorn'
begin; require 'airbrake/capistrano'; rescue LoadError; end

