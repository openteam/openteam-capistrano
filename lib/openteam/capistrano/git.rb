set :repo_url, `git config --get remote.origin.url`.chomp
set :branch,   fetch(:stage)
set :user,     `git config --get user.name`.chomp
