after  'deploy',            'deploy:tagging:create'
after  'deploy:publishing', 'unicorn:restart'
after  'unicorn:restart',   'airbrake:deploy'
before 'deploy:cleanup',    'deploy:tagging:clean'
before 'deploy:reverted',   'whenever:clear_crontab' if used_whenever?
before 'deploy:updated',    'whenever:clear_crontab' if used_whenever?
