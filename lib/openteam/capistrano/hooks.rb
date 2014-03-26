before 'deploy:cleanup',    'deploy:tagging:clean'
after  'deploy',            'deploy:tagging:create'
after  'deploy:publishing', 'unicorn:restart'
after  'unicorn:restart',   'airbrake:deploy'
