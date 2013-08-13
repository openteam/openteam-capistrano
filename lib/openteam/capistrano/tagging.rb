Capistrano::Configuration.instance.load do
  before 'deploy:cleanup', 'tagging:cleanup'
  after  'deploy',         'tagging:deploy'

  namespace :tagging do
    def tag_name(options={})
      formatted_local_time = DateTime.strptime(options[:for], '%Y%m%d%H%M%S').to_time.strftime("%Y.%m.%d-%H%M")
      "#{stage}-#{formatted_local_time}"
    end

    def create_tag(tag_name)
      run_locally "git tag -a #{tag_name} -m 'Deployed by #{fetch(:local_user)}' origin/#{fetch(:branch)}"
      run_locally "git push origin #{tag_name}"
    end

    def remove_tags(tags)
      tag_refs = tags.map{|tag| ":refs/tags/#{tag}"}
      run_locally "git tag -d #{tags.join(' ')}"
      run_locally "git push origin #{tag_refs.join(' ')}"
    end

    set(:stage_tags) do
      run_locally('git fetch --tags')
      run_locally("git tag -l").chomp.split("\n").grep(/^#{stage}-/)
    end

    set(:kept_releases_count) { fetch(:keep_releases, 5) }
    set(:kept_releases) { releases.last(kept_releases_count) }
    set(:kept_tags) { kept_releases.map{|release| tag_name(:for => release)} }
    set(:rotten_tags) { stage_tags - kept_tags }

    desc "Create release tag in local and origin repo"
    task :deploy do
      logger.info "tag current release"
      create_tag tag_name(:for => release_name)
    end

    desc "Remove release tag from local and origin repo"
    task :cleanup do
      if rotten_tags.any?
        logger.info "keeping #{kept_releases_count} of #{stage} #{stage_tags.size} stage tags"
        remove_tags(rotten_tags)
      else
        logger.important "no old release tags to clean up"
      end
    end
  end
end
