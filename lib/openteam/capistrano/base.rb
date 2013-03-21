require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano/ext/multistage'

#require 'capistrano-deploytags'
require 'capistrano-db-tasks'
require 'capistrano-unicorn'
begin; require 'airbrake/capistrano'; rescue LoadError; end
begin; require 'whenever/capistrano'; resque LoadError; end

Capistrano::Configuration.instance.load do
  def deploy_config_parsed_yaml
    YAML::load(File.open('config/deploy.yml'))
  end

  def deploy_config
    @deploy_config ||= (stage ? deploy_config_parsed_yaml[stage.to_s] : deploy_config_parsed_yaml) || {}
  end

  def run_rake(task, options={})
    directory = options[:in] || release_path
    run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{task}"
  end

  set(:application)       { deploy_config['application'] }
  set(:domain)            { deploy_config['domain'] }
  set(:gateway)           { deploy_config['gateway'] }

  set(:deploy_to)         { "/srv/#{application}" }

  set :scm,               :git
  set(:repository)        { `git config --get remote.origin.url`.strip }

  set :branch,            :master
  set :deploy_via,        :remote_cache
  set :ssh_options,       { :forward_agent => true }

  set :keep_releases,     7

  # this files will be symlinked from shared to current path on deploy
  set :shared_children,   %w[config/settings.yml config/database.yml log tmp/sockets tmp/pids]

  # for assets compilation on host with nodejs
  set :default_shell,     "bash -l"

  # make bin stubs for candy console rails runs
  set :bundle_flags,      "--binstubs --deployment --quiet"

  # gem capistrano-db-tasks
  # we do not need dump file after db:pull
  set :db_local_clean,    true

  # gem whenever
  # point to bundled version of whenever command
  set :whenever_command,  "bundle exec whenever"

  # set up hooks
  after('multistage:ensure') do
    server domain, :app, :web, :db, :primary => true
  end

  after "deploy:update_code", "deploy:migrate"

  after "deploy",             "unicorn:restart"

  after "deploy",             "deploy:cleanup"
end
