set :log_level,      :info
set :db_local_clean, true
set :db_remote_clean, true
set :bundle_binstubs, -> { shared_path.join('bin')  }
