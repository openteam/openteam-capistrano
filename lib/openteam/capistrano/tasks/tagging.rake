namespace :deploy do
  namespace :tagging do
    desc 'Create release tag in local and origin repo'
    task :create do
      Openteam::Capistrano::Tag.new.create
    end

    desc 'Remove release tag from local and origin repo'
    task :clean do
      Openteam::Capistrano::Tag.new.clean
    end
  end
end
