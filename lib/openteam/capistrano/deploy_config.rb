if used_deploy_config?
  YAML::load(File.open('config/deploy.yml'))[fetch(:stage).to_s].each do |k, v|
    set k, v
  end if fetch(:stage)
else
  raise 'ERROR: config/deploy.yml not found!'
end
