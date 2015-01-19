require 'rails/generators'
require 'generators/ahoy/base'
require 'fileutils'

module Ahoy
  class DeployGenerator < Ahoy::Generator::Base

    def use_deploy
      defaults('No')
      @use_deploy = yes?('=> Would you like to setup deployment files using Puma and Mina? [enter for default]')
    end

    def prompt_user
      if @use_deploy
        @github_repo = ask('=> What is the github repository for this application?').chomp
        defaults('127.0.0.1')
        @server_ip = ask('=> Which IP address will you be deploying to? [enter for default]').chomp
        defaults('22')
        @server_ssh_port = ask('=> What SSH port would you like to use on your server? [enter for default]').chomp
        copy_templates
        add_gems
        change_permissions
      else
        puts 'Skipping deployment scripts'
      end
    end

    private

    def copy_templates
      template '_puma.sh', 'bin/puma.sh'
      template '_puma.rb', 'config/puma.rb'
      template '_deploy.rb', 'config/deploy.rb'
    end

    def add_gems
      gem_group :production do
        gem 'puma'
        gem 'rb-readline'
      end
    end

    def change_permissions
      FileUtils.chmod 0751, 'bin/puma.sh'
    end
  end
end
