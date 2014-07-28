after  'deploy',            'deploy:tagging:create'
after  'deploy:publishing', 'unicorn:restart'
after  'unicorn:restart',   'airbrake:deploy'
before 'deploy:cleanup',    'deploy:tagging:clean'
after  'sunspot:pull',      'sunspot:reload' if used_solr?
after  'sunspot:clear',     'sunspot:reload' if used_solr?
