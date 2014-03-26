if fetch(:stage)
  require 'openteam/capistrano/helpers'
  require 'openteam/capistrano/capistrano_config'
  require 'openteam/capistrano/deploy_config'
  require 'openteam/capistrano/app_config'
  require 'openteam/capistrano/git'
  require 'openteam/capistrano/hooks'
  require 'openteam/capistrano/shared'
  require 'openteam/capistrano/ssh'
  require 'openteam/capistrano/tagging'
  require 'openteam/capistrano/unicorn'           if used_unicorn?
end