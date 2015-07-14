working_directory "/home/deploy/plataform/development/current"

pid "#{working_directory}/tmp/pids/unicorn.pid"
stderr_path "#{working_directory}/log/unicorn.log"
stdout_path "#{working_directory}/log/unicorn.log"

listen "#{working_directory}/tmp/unicorn.plataform.sock"
listen "#{working_directory}/tmp/unicorn.plataform.sock"

worker_processes 4
timeout 30