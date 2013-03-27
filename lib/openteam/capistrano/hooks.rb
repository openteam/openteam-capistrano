# set up hooks
Capistrano::Configuration.instance.load do
  after 'deploy:update_code', 'deploy:migrate' if use_db?
  after 'deploy:restart',     'unicorn:restart'
  after 'deploy',             'deploy:cleanup'
end
