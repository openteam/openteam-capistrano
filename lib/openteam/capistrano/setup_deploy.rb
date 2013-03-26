Capistrano::Configuration.instance.load do
  after 'multistage:ensure', 'openteam_capistrano_setup_deploy'

  task :openteam_capistrano_setup_deploy do
    set :deploy_config,     YAML::load(File.open('config/deploy.yml'))[stage.to_s]

    # application name
    set :application,       deploy_config['application']

    # deployment host
    set :domain,            deploy_config['domain']

    #  deloyment gateway
    set:gateway,            deploy_config['gateway'] if deploy_config.has_key? 'gateway'

    # application root
    set :deploy_to,         "/srv/#{application}"

    # setup server
    server domain, :app, :web, :db, :primary => true
  end
end
