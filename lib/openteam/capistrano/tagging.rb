Capistrano::Configuration.instance.load do
  namespace :tagging do
    def tag_name(options={})
      formatted_local_time = DateTime.strptime(options[:for], '%Y%m%d%H%M%S').to_time.strftime("%Y.%m.%d-%H%M")
      "#{fetch(:stage)}-#{formatted_local_time}"
    end

    def create_tag(tag_name)
      run_locally "git tag -a #{tag_name} -m 'Deployed by #{fetch(:local_user)}' origin/#{fetch(:branch)}"
      run_locally "git push origin --tags"
    end

    def remove_tag(tag_name)
      run_locally "git tag -d #{tag_name} || true"
      run_locally "git push origin :refs/tags/#{tag_name}"
    end

    desc "Create release tag in local and origin repo"
    task :deploy do
      logger.info "tag current release"
      create_tag tag_name(:for => release_name)
    end

    desc "Remove release tag from local and origin repo"
    task :cleanup do
      count = fetch(:keep_releases, 5)

      if count >= releases.size
        logger.important "no old release tags to clean up"
      else
        logger.info "keeping #{count} of #{releases.size} release tags"
        releases.first(releases.size - count).map do |release|
          remove_tag tag_name(:for => release)
        end
      end
    end
  end
end
