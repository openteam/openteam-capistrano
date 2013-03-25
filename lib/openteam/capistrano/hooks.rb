# set up hooks
Capistrano::Configuration.instance.load do
  after('multistage:ensure') do
    server domain, :app, :web, :db, :primary => true
  end

  after 'deploy:update_code', 'deploy:migrate'
  after 'deploy:restart',     'unicorn:restart'
  after 'deploy',             'deploy:cleanup'
end
