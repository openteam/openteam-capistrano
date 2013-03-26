Capistrano::Configuration.instance.load do
  set :scm,               :git
  set(:ssh_repository)    { `git config --get remote.origin.url`.chomp }
  set(:repository)        { ssh_repository.gsub(/^git@(.+?):(.+)$/, 'git://\1/\2') }
  set :branch,            :master
  set :deploy_via,        :remote_cache
  set :ssh_options,       {:forward_agent => true}
end
