Capistrano::Configuration.instance.load do
  def deploy_config
    @deploy_config ||= YAML::load(File.open('config/deploy.yml'))[stage.to_s]
  end

  set(:application)       { deploy_config['application'] }
  set(:domain)            { deploy_config['domain'] }
  set(:gateway)           { deploy_config['gateway'] }

  set(:deploy_to)         { "/srv/#{application}" }

  # source repostitory settings
  set :scm,               :git
  set(:repository)        { `git config --get remote.origin.url`.strip }
  set :branch,            :master
  set :deploy_via,        :remote_cache
  set :ssh_options,       { :forward_agent => true }

  # this files will be symlinked from shared to current path on deploy
  set :shared_children,   %w[config/settings.yml config/database.yml log tmp/sockets tmp/pids]

  # for assets compilation on host with nodejs
  set :default_shell,     'bash -l'

  # make bin stubs for candy console rails runs
  set :bundle_flags,      '--binstubs --deployment --quiet'

  # gem capistrano-db-tasks
  # we do not need dump file after db:pull
  set :db_local_clean,    true

  # gem whenever
  # point to bundled version of whenever command
  set :whenever_command,  'bundle exec whenever'

  # tagging needs this
  set :local_user,        ENV['USER'] || ENV['USERNAME']
end
