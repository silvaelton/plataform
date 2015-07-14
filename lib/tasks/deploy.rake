namespace :deploy do
  desc 'Deploy Staging'
  namespace :stage do
    task :deploy do 
      exec 'mina deploy -f config/deploy/staging.rb'
    end

    task :migrate do 
      exec 'mina deploy -f config/deploy/staging.rb'
    end

    task :setup do 
      exec 'mina setup  -f config/deploy/staging.rb'
    end
  end

  task :production do 
    puts 'loading to deploy in production...'
  end
end