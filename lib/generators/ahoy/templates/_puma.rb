workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'production'

daemonize true

pidfile "/var/www/<%= Rails.application.class.parent_name.underscore %>/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/<%= Rails.application.class.parent_name.underscore %>/shared/tmp/log/stdout", "/var/www/<%= Rails.application.class.parent_name.underscore %>/shared/tmp/log/stderr"

bind "unix:///var/www/<%= Rails.application.class.parent_name.underscore %>/shared/tmp/sockets/puma.sock"

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end
