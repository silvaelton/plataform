namespace :deploy do
  [:development, :production].each do |name_task| 
    namespace name_task do
      
      task :deploy do 
        exec "mina deploy -f config/deploy/#{name_task}.rb"
      end
  
      task :migrate do 
        exec "mina migrate -f config/deploy/#{name_task}.rb"
      end

      task :rollback do 
        exec "mina rollback -f config/deploy/#{name_task}.rb"
      end
  
      task :setup do 
        exec "mina setup  -f config/deploy/#{name_task}.rb"
      end

      task :backup do
        exec "mina backup -f config/deploy/#{name_task}.rb"
      end
    end
  end
end