working_directory "/home/deploy/plataform/current/"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/deploy/plataform/current/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/deploy/plataform/current/log/unicorn.log"
stdout_path "/home/deploy/plataform/current/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.plataform.sock"
listen "/tmp/unicorn.plataform.sock"
worker_processes 4
timeout 30