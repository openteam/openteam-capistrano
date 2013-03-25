Capistrano::Configuration.instance.load do
  after 'multistage:ensure', 'openteam:setup'

  namespace :openteam do
    task :setup do
      def deploy_config
        @deploy_config ||= YAML::load(File.open('config/deploy.yml'))[stage.to_s]
      end

      def ssh_git_repository_url
        `git config --get remote.origin.url`.chomp
      end

      def git_repository_url
        @git_repository_url ||=  ssh_git_repository_url.gsub(/^git@(.+?):(.+)$/, 'git://\1/\2')
      end

      set :application,       deploy_config['application']
      set :domain,            deploy_config['domain']
      set :gateway,           deploy_config['gateway'] if deploy_config.has_key? 'gateway'

      # application root
      set :deploy_to,         "/srv/#{application}"

      # do not use sudo by default
      set :use_sudo,          false

      # source repostitory settings
      set :scm,               :git
      set :repository,        git_repository_url
      set :branch,            :master
      set :deploy_via,        :remote_cache
      set :ssh_options,       {:forward_agent => true}

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

      # subscriber name
      set :subscriber_name,   "#{application}-subscriber"

      # setup server
      server domain, :app, :web, :db, :primary => true
    end
  end
end
