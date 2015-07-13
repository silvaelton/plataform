# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'plataform'
set :repo_url, 'https://github.com/eltonchrls/plataform.git'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name

# Default value for :scm is :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :forward_agent, true
set :deploy_via, :remote_cache

after "deploy", "deploy:cleanup"
# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :use_sudo, true
set :linked_dirs, %w{bin log tmp vendor/bundle public/system public/sitemaps}


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do 
      on roles :app do
        sudo "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end
 
  task :setup_config do
    on roles :app do
      sudo "rm -f /etc/nginx/sites-enabled/default"
      sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
      sudo "mkdir -p #{shared_path}/config"
      puts "Now edit #{shared_path}/config/database.yml and add your username and password"
    end
  end
 
  
  task :symlink_config do 
    on roles :app, in: :sequence, wait: 1 do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
  
 
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles :app do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

end
