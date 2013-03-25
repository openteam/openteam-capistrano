if File.exists?('script/subscriber')
  Capistrano::Configuration.instance.load do
    # set subscriber hooks
    after 'deploy:update',      'subscriber:restart'
    after 'deploy:rollback',    'subscriber:restart'

    namespace :subscriber do
      def subsriber_pid_file
        "#{current_path}/tmp/pids/#{subscriber_name}.pid"
      end

      desc "Stop rabbitmq subscriber"
      task :stop do
        # subscriber will remove pid file automatically
        run "if [ -s #{subsriber_pid_file} ]; then kill `cat #{subsriber_pid_file}`; fi"
      end

      desc "Start rabbitmq subscriber"
      task :start do
        run "RAILS_ENV=#{rails_env} #{current_path}/script/subscriber --name #{subscriber_name} start"
      end

      desc "Restart rabbitmq subscriber"
      task :restart do
        stop
        start
      end
    end
  end
end
