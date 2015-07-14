require 'mina/bundler' 
require 'mina/rails' 
require 'mina/git' 
require 'mina/rvm'

set :domain, '10.36.25.14' 
set :term_mode,       :system

set :app_name, 'plataform'
set :user,  'development'
set :deploy_to, "/home/deploy/plataform" 
set :repository, 'https://github.com/eltonchrls/plataform.git'
set :branch, 'master'

set :app_path,        "#{deploy_to}/#{current_path}"
set :shared_paths,    ['public/static', 'tmp']
set :keep_releases,   5

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

task :setup do
  queue! %{
    mkdir -p "#{deploy_to}/shared/tmp/pids"
  }
end



desc "deploys the current version to the server."
task :reload => :environment do
  deploy do
    invoke 'git:clone'
    invoke 'bundle:install'
  end
end

desc "deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke 'git:clone'
    invoke 'bundle:install'
    invoke 'rails:db_migrate'
    invoke 'rails:assets_precompile'
    invoke 'deploy:link_shared_paths'
 
    to :launch do
      invoke :'unicorn:restart'
    end
  end
end
 

namespace :unicorn do
  set :unicorn_pid, "#{app_path}/tmp/pids/unicorn.pid"
  set :start_unicorn, %{
    cd #{app_path}
    bundle exec unicorn -c #{app_path}/config/unicorn.rb -E #{rails_env} -D
  }
 
#                                                                    Start task
# ------------------------------------------------------------------------------
  desc "Start unicorn"
  task :start => :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! start_unicorn
  end
 
#                                                                     Stop task
# ------------------------------------------------------------------------------
  desc "Stop unicorn"
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      test -s "#{unicorn_pid}" && kill -QUIT `cat "#{unicorn_pid}"` && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end
 
#                                                                  Restart task
# ------------------------------------------------------------------------------
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end