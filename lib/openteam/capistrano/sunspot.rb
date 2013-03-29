Capistrano::Configuration.instance.load do
  namespace :sunspot do
    desc "Synchronize your local solr using remote solr data"
    task :pull do
      set(:ruby_expression)       { "puts YAML.load_file('#{current_path}/config/settings.yml')['solr']['url']" }
      set(:remote_solr_url)       { capture("ruby -ryaml -e \"#{ruby_expression}\"").chomp }

      require File.expand_path('../solr/solr', __FILE__)

      Solr::Replicator.new(:remote => remote_solr_url, :local => 'http://localhost:8982/solr').replicate
    end
  end
end
