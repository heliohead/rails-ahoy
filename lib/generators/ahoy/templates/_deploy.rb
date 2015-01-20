require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

task :setup_variables => :environment do
  set :user,          '<%= Ahoy::VariableStore.variables['server_user'] %>'
  set :domain,        '<%= Ahoy::VariableStore.variables['server_domain'] %>'
  set :port,          '<%= Ahoy::VariableStore.variables['server_ssh_port'] %>'
  set :repository,    '<%= Ahoy::VariableStore.variables['app_repo'] %>'
  set :branch,        '<%= Ahoy::VariableStore.variables['app_repo_branch'] %>'
  set :forward_agent, true
  set :deploy_to,     '/var/www/<%= Ahoy::VariableStore.variables['app_name'] %>'
  set :app_path,      '/var/www/<%= Ahoy::VariableStore.variables['app_name'] %>/current'
  set :shared_paths,  ['config/database.yml', 'config/secrets.yml', 'log', 'tmp', '.env/production_env.yml']
end

task :production do
  invoke :setup_variables
end

task :environment do
  queue! %[export PATH="/usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH"]
end

task :setup => :environment do
  ['log', 'config', 'tmp/log', 'tmp/pids', 'tmp/sockets'].each do |dir|
    queue! %[mkdir -m 750 -p "#{deploy_to}/#{shared_path}/#{dir}"]
  end
end

task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
    to :launch do
      invoke :'server:restart'
    end
  end
end

namespace :server do
  [:start, :stop, :restart].each do |action|
    task action => :environment do
      queue "cd #{app_path} && RAILS_ENV=#{settings[:rails_env]} && bin/puma.sh #{action}"
    end
  end
end
