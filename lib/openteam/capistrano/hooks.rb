# set up hooks
Capistrano::Configuration.instance.load do
  after 'deploy:update_code', 'deploy:migrate'
  after 'deploy:restart',     'unicorn:restart'
  after 'deploy',             'deploy:cleanup'
end
