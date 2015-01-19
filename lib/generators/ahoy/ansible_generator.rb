require 'rails/generators'
require 'generators/ahoy/base'
require 'fileutils'

module Ahoy
  class AnsibleGenerator < Ahoy::Generator::Base

    def prompt_user
      defaults('127.0.0.1')
      @server_ip = ask('=> Which IP address will you be deploying to? [enter for default]').chomp
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
      template 'ansible_templates/_provision.sh', 'config/ansible/provision.sh'
      template 'ansible_templates/_hosts', 'config/ansible/hosts'
      template 'ansible_templates/playbooks/group_vars/_all.yml', 'config/ansible/playbooks/group_vars/all.yml'
      template 'ansible_templates/playbooks/host_vars/_production_root.yml', 'config/ansible/playbooks/host_vars/production_root.yml'
      template 'ansible_templates/playbooks/host_vars/_production_deploy.yml', 'config/ansible/playbooks/host_vars/production_deploy.yml'
      template 'ansible_templates/playbooks/roles/security/tasks/_ssh_settings.yml', 'config/ansible/playbooks/roles/security/tasks/ssh_settings.yml'
    end

    def change_permissions
      FileUtils.chmod 0751, 'config/ansible/provision.sh'
    end
  end
end
