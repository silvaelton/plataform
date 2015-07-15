app_path = "/home/deploy/plataform/development/current"

working_directory "/home/deploy/plataform/development/current"

pid "#{app_path}/tmp/pids/unicorn.pid"
stderr_path "#{app_path}/log/unicorn.log"
stdout_path "#{app_path}/log/unicorn.log"

listen "#{app_path}/tmp/unicorn.plataform.sock"
listen "#{app_path}/tmp/unicorn.plataform.sock"

worker_processes 4
timeout 30