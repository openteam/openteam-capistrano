require 'capistrano/ext/multistage'

require 'bundler/capistrano'
require 'rvm/capistrano'

require 'capistrano-db-tasks' if use_db?
require 'capistrano-unicorn'

# airbrake
begin
  require 'airbrake/capistrano'
rescue LoadError
  STDERR.puts '!!! WARNING: airbrake not detected, deployment notifications has been disabled !!!'
end


# delayed job
begin
  require 'delayed/recipes'
  Capistrano::Configuration.instance.load { after 'deploy:restart', 'delayed_job:restart' }
rescue LoadError
end

