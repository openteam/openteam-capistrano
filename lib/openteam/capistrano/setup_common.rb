Capistrano::Configuration.instance.load do
  # do not use sudo by default
  set :use_sudo,          false

  # source repostitory settings
  # this files will be symlinked from shared to current path on deploy:create_symlinks
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
