require 'fileutils'
require 'rsolr'
require 'sunspot_solr'
require 'tmpdir'

class Solr
  class Replicator
    attr_accessor :remote, :local

    def initialize(options)
      self.remote = Solr.new options[:remote]
      self.local = Solr.new options[:local]
    end

    def replicate
      if same_versions?
        puts 'local and remote index versions are same, no need for replication'
      else
        really_replicate
      end
    end

    private
    def really_replicate
      print 'wait while solr replicated '
      local.send_replication_command :fetchindex, :masterUrl => "#{remote.url}/replication"
      while !same_versions?
        print '.'
        sleep 0.5
      end
      puts ' ok'
    end

    def print(*args)
      STDOUT.print *args
      STDOUT.sync
    end

    def same_versions?
      remote.index_version == local.index_version
    end
  end

  attr_accessor :url

  def initialize(url)
    self.url = url
  end

  def index_version
    send_replication_command(:indexversion)['indexversion']
  end

  def send_replication_command(command, extra={})
    solr.get :replication, :params => {:command => command}.merge(extra)
  rescue Errno::ECONNREFUSED
    STDERR.puts "!!! ensure solr started on #{url} !!!"
    raise "couldn't connect to #{url}"
  rescue RSolr::Error::Http => e
    STDERR.puts "!!! ensure solr replication handler configured on #{url} !!!"
    raise "could not find replication handler on #{url}"
  end

  private

  def solr
    @solr ||= RSolr.connect :url => url
  end
end

