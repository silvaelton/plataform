require 'mina/bundler' 
require 'mina/rails' 
require 'mina/git' 
require 'mina/rvm'
require 'mina/unicorn'

set :domain, '10.36.25.14' 
set :app_name, 'plataform'
set :user,  'development'
set :deploy_to, '/home/deploy/plataform' 
set :repository, 'https://github.com/eltonchrls/plataform.git'
set :branch, 'master'

set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"


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

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue  %[cp #{deploy_to}/current/config/database.sample.yml shared/config/database.yml]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'unicorn:restart'
    end
  end
end