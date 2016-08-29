begin
  require 'rsolr'
  require File.expand_path('../../solr/solr', __FILE__)

  def development_solr_url
    @development_solr_url ||= ''.tap do |s|
      begin
        s << YAML.load_file('config/settings.yml')['solr']['url']
      rescue
        puts 'Can\'t read solr settings'
        exit
      end
    end
  end

  def development_core
    @development_core ||= development_solr_url.match('(?<=/)\w+\z').to_s
  end

  namespace :sunspot do
    desc 'Synchronize your local solr using remote solr data'
    task :pull do
      puts
      remote_solr_url = ''

      on roles(:web) do
        ruby_expression = "puts YAML.load_file('#{current_path}/config/settings.yml')['solr']['url']"
        remote_solr_url = capture(:ruby, " -ryaml -e \"#{ruby_expression}\"")
      end

      Solr::Replicator.new(remote: remote_solr_url, local: development_solr_url).replicate
    end

    desc 'Reload development core'
    task :reload do
      puts
      Solr.new(development_solr_url).send_reload_core_command(development_core)
    end

    desc 'Clear development index'
    task :clear do
      puts
      Solr.new(development_solr_url).send_clear_command(development_core)
    end
  end
rescue LoadError
end
