set :port, 22
set :branch, 'master'

role :app, "development@10.36.25.14"

set :deploy_to, "/home/apps/plataform"
set :pty, true
