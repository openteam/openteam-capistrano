if File.exists?('script/subscriber')
  Capistrano::Configuration.instance.load do
    after 'deploy:update',      'subscriber:restart'
    after 'deploy:rollback',    'subscriber:restart'

    namespace :subscriber do
      desc "Stop rabbitmq subscriber"
      task :stop do
        run "RAILS_ENV=#{rails_env} #{current_path}/script/subscriber stop"
      end

      desc "Start rabbitmq subscriber"
      task :start do
        run "RAILS_ENV=#{rails_env} #{current_path}/script/subscriber start"
      end

      desc "Restart rabbitmq subscriber"
      task :restart do
        stop
        start
      end
    end
  end
end
