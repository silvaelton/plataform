require 'mina/bundler' 
require 'mina/rails' 
require 'mina/git' 
require 'mina/rvm'

set :domain, '10.36.25.14' 
set :user,  'development'
set :deploy_to, '/home/deploy/plataform' 
set :repository, 'https://github.com/eltonchrls/plataform.git'
set :branch, 'master'

set :shared_paths, ['config/database.yml', 'log']

task :environment do
  invoke :'rvm:use[ruby-2.2.1]'
end

task :down do
  invoke :restart
  invoke :logs
end

task :restart do
  queue 'sudo service nginx restart'
end

task :logs do
  queue 'tail -f /var/log/nginx/error.log'
end

task :deploy => :environment do 
  deploy do 
    invoke :'git:clone' 
    invoke :'deploy:link_shared_paths' 
    invoke :'bundle:install' 
    invoke :'rails:db_migrate' 
    invoke :'rails:assets_precompile' 
    
    to :launch do 
      queue "touch #{deploy_to}/tmp/restart.txt" 
    end 
  end 
end