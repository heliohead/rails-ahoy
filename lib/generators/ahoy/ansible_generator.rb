require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class AnsibleGenerator < Ahoy::Generator::Base

    def prompt_user
      defaults('127.0.0.1')
      @server_ip = ask('=> What is the IP address of the server you will deploy to? [enter for default]').chomp
      defaults('22')
      @server_ssh_port = ask('=> What SSH port would you like to use on your server? [enter for default]').chomp
      defaults('2.1.5')
      @ruby_version = ask('=> Which version of Ruby would you like to install? [enter for default]').chomp
      defaults('9.3')
      @postgresql_version = ask('=> Which version of PostgreSQL would you like to install? [enter for default]').chomp
    end

    def copy_directory
      directory 'ansible', 'config/ansible'
    end

    def copy_templates
      template 'ansible_templates/_hosts', 'config/ansible/hosts'
      template 'ansible_templates/playbooks/group_vars/_all.yml', 'config/ansible/playbooks/group_vars/all.yml'
      template 'ansible_templates/playbooks/host_vars/_production_root.yml', 'config/ansible/playbooks/host_vars/production_root.yml'
      template 'ansible_templates/playbooks/host_vars/_production_deploy.yml', 'config/ansible/playbooks/host_vars/production_deploy.yml'
    end
  end
end
