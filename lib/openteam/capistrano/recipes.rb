def use_db?
  @use_db ||= File.exists?('config/database.yml') || File.exists?('config/database.yml.example')
end

require "openteam/capistrano/dependencies"
require "openteam/capistrano/hooks"
require "openteam/capistrano/setup_common"
require "openteam/capistrano/setup_deploy"
require "openteam/capistrano/setup_git"
require "openteam/capistrano/subscriber"
require "openteam/capistrano/tagging"
