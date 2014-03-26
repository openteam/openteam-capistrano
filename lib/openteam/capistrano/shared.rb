set :linked_dirs,  %w{ bin bundle log public/system tmp/cache tmp/pids tmp/sockets }
set :linked_files, %w{ config/settings.yml }

set :linked_files, fetch(:linked_files) + %w{ config/database.yml } if used_db?
