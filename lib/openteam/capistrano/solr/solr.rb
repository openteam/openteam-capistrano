require 'fileutils'
require 'rsolr'
require 'tmpdir'

class Solr
  class Replicator
    attr_accessor :remote, :local, :base_local_index_version

    def initialize(options)
      self.remote = Solr.new options[:remote]
      self.local = Solr.new options[:local]
    end

    def replicate
      self.base_local_index_version = local.index_version
      if base_local_index_version == remote.index_version
        puts 'No need for replication. The local index and the remote index are the same.'
      else
        really_replicate
      end
    end

    private

    def really_replicate
      print 'Wait while solr replicated '
      local.send_replication_command :fetchindex, masterUrl: remote.url.to_s
      while base_local_index_version == local.index_version
        print '.'
        sleep 0.5
      end
      puts ' OK'
    end

    def print(*args)
      STDOUT.print *args
      STDOUT.sync
    end
  end

  attr_accessor :url

  def initialize(url)
    self.url = url
  end

  def index_version
    send_version_command['indexversion'].to_i
  end

  def send_version_command
    send_command 'replication',         params: { command: :indexversion }
  end

  def send_replication_command(command, extra = {})
    send_command 'replication',         params: { command: command }.merge(extra)
    puts 'Index has been successfully received'
  end

  def send_reload_core_command(core)
    send_command '/cores/admin/cores', params: { action: 'RELOAD', core: core }
    puts "The '#{core}' core has been successfully reloaded"
  end

  def send_clear_command(core)
    send_command 'update', params: { :commit => true, 'stream.body' => '<delete><query>*:*</query></delete>' }
    puts "The '#{core}' core has been successfully cleared"
  end

  private

  def solr
    @solr ||= RSolr.connect url: url
  end

  def send_command(href, params)
    solr.get href, params
  rescue Errno::ECONNREFUSED
    STDERR.puts "!!! ensure solr started on '#{url}' !!!"
    puts "Couldn't connect to '#{url}'"
    exit
  rescue RSolr::Error::Http #=> e
    STDERR.puts '!!! RSolr error !!!'
    puts "Could not perform action '#{href}'"
    exit
  end
end
