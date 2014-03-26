module Openteam
  module Capistrano
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_capfile
        template 'Capfile'
      end

      def create_deploy_config
        template 'config/deploy.rb'
      end

      def create_deploy_stages
        template 'config/deploy/production.rb'
      end

      def create_unicorn_config
        template 'config/unicorn.rb'
      end
    end
  end
end
