set :repo_url, %x( git config --get remote.origin.url ).chomp
set :branch,   fetch(:stage)
set :user,     %x( git config --get user.name ).chomp
