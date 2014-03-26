require 'capistrano/deploy'

module Openteam
  module Capistrano
    class Tag
      def create
        %x( git tag -a '#{tag_name}' -m 'Deployed by #{fetch(:user)}' origin/#{fetch(:branch)} )
        %x( git push origin '#{tag_name}' )
      end

      def clean
        get_tags
        return if rotten_tags.empty?
        %x( git tag -d #{rotten_tags.join(' ')} )
        %x( git push origin #{rotten_tags.map{|t| ":refs/tags/#{t}"}.join(' ')} )
      end

      private

      def tag_name
        @tag_name ||= "#{fetch(:stage)}-#{formatted_local_time}"
      end

      def formatted_local_time
        Time.now.strftime("%Y.%m.%d-%H%M")
      end

      def get_tags
        %x( git fetch --tags )
      end

      def stage_tags
        @stage_tags ||= %x( git tag -l origin/#{fetch(:branch)} ).chomp.split("\n").grep(/^#{fetch(:stage)}-/)
      end

      def rotten_tags
        stage_tags[0..-fetch(:keep_releases)-1]
      end
    end
  end
end
