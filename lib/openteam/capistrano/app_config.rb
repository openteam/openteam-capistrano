role  :app,                 [fetch(:domain)]
role  :web,                 [fetch(:domain)]
role  :db,                  [fetch(:domain)]
set   :deploy_to,           "/srv/#{fetch(:application)}"
