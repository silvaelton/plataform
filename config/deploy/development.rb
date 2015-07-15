require 'mina/bundler' 
require 'mina/rails' 
require 'mina/git' 
require 'mina/rvm'

set :app_name, ENV['APP_NAME']

set :term_mode,       :system
set :rails_env,       'development'

set :domain, ENV["STAGE_HOST_SERVER"]

set :deploy_to,   "/home/deploy/#{app_name}/#{rails_env}"
set :app_path,    "#{deploy_to}/#{current_path}"

set :repository,  ENV["GITHUB_REPO"]
set :branch,      ENV["STAGE_BRANCH"]

set :shared_paths,    ['public/static', 'tmp']
set :keep_releases,   5
#
# ========================== RVM ===============================

task :environment do
  invoke :'rvm:use[ruby-2.2.1]'
end



#
# ========================== BACKUP =============================

desc "configure setup to application"
task :setup => :environment do
  deploy do
    invoke 'git:clone'
    invoke 'bundle:install'
    queue! "sudo rm /etc/nginx/sites-enabled/#{app_name} || true"
    queue! "sudo ln -s #{app_path}/config/nginx/#{rails_env}.conf /etc/nginx/sites-enabled/#{app_name} || true"
  end
end

#
# ========================== DEPLOY APPLICATION =================

desc "deploy current version"
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
 
#
# ========================== UNICORN FUNCTION FOR DEPLOY ===========

namespace :unicorn do
  set :unicorn_pid, "#{app_path}/tmp/pids/unicorn.pid"
  set :start_unicorn, %{
    cd #{app_path}
    RAILS_ENV=development unicorn_rails -c #{app_path}/config/unicorn/#{rails_env}.rb -D
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