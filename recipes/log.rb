Capistrano::Configuration.instance(:must_exist).load do
 
  namespace :log do
    namespace :tail do
      desc "Tail all remote logs"
      task :default, :roles => :app do
        log.tail.nginx
        log.tail.mongrel
        log.tail.production
      end
      
      desc "Tail the remote Nginx log"
      task :nginx, :roles => :app do
        puts 'Nginx ' + '=' * 100
        run_puts "tail -100 #{shared_path}/log/nginx.log"
      end
      
      desc "Tail the remote Mongrel log"
      task :mongrel, :roles => :app do
        (mongrel_port..(mongrel_port + production_mongrels - 1)).each do |port|
          puts "Mongrel #{port} " + '=' * 100
          run_puts "tail -100 #{shared_path}/log/mongrel.#{port}.log"
        end
      end
      
      desc "Tail the remote Rails production log"
      task :production, :roles => :app do
        puts 'Production ' + '=' * 100
        run_puts "tail -100 #{shared_path}/log/production.log"
      end
    end
  end
  
end