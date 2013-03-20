Capistrano::Configuration.instance.load do
  def deploy_config_parsed_yaml
    YAML::load(File.open('config/deploy.yml'))
  end

  def deploy_config
    @deploy_config ||= (stage ? deploy_config_parsed_yaml[stage.to_s] : deploy_config_parsed_yaml) || {}
  end

  def run_rake(task, options={})
    directory = options[:in] || release_path
    run "'d #{directory} && #{rake} RAILS_ENV=#{rails_env} #{task}"
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

  # capistrano-db-tasks
  # we do not need dump file after loading
  set :db_local_clean,    true

  # for assets compilation on host with nodejs
  set :default_shell,     "bash -l"

  # set up hooks
  after('multistage:ensure') do
    server domain, :app, :web, :db, :primary => true
  end

  after('deploy:finalize_update') do
    run "ln -s #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  end

  after "deploy",         "deploy:migrate"
end
