begin
  require 'active_record'
  @used_db = true
rescue LoadError
end

begin
  require 'delayed_job'
  @used_delayed_job = true
rescue LoadError
end

begin
  require 'sidekiq'
  @used_sidekiq = true
rescue LoadError
end

begin
  require 'bunny'
  @used_rmq = true
rescue LoadError
end

begin
  require 'rsolr'
  @used_solr = true
rescue LoadError
end

begin
  require 'unicorn'
  @used_unicorn = true
rescue LoadError
end


def used_db?
  !@used_db.nil?
end

def used_delayed_job?
  !@used_delayed_job.nil?
end

def used_deploy_config?
  @used_deploy_config ||= File.exists?('config/deploy.yml')
end

def used_sidekiq?
  !@used_sidekiq.nil?
end

def used_rails?
  @used_rails ||= File.exists?('config/application.rb') && File.exists?('config/environment.rb')
end

def used_rmq?
  !@used_rmq.nil?
end

def used_solr?
  !@used_solr.nil?
end

def used_unicorn?
  !@used_unicorn.nil?
end

def used_whenever?
  @used_whenever ||= File.exists?('config/schedule.rb')
end
