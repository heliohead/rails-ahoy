require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class VagrantGenerator < Ahoy::Generator::Base

    def use_vagrant
      defaults('No')
      @use_vagrant = yes?('=> Would you like to use Vagrant with your project?')
    end

    def prompt_user
      if @use_vagrant
        defaults('2')
        @memory = ask('=> How many Megabytes of memory would you like to allocate to your VM? [enter for default]').to_i
        defaults('1')
        @cpus = ask('=> How many CPUs would you like to allocated? [enter for default]').to_i
        copy_templates
        append_ansible_playbook
      else
        puts 'Skipping Vagrant'
      end
    end

    private

    def copy_templates
      template '_Vagrantfile', 'Vagrantfile'
      template '_database.yml', 'config/database.yml'
      template 'ansible_templates/playbooks/host_vars/_default.yml', 'config/ansible/playbooks/host_vars/default.yml'
    end

    def append_ansible_playbook
      append_file 'config/ansible/playbooks/playbook.yml', VAGRANT_PLAYBOOK
    end
  end
end

VAGRANT_PLAYBOOK = "
# Vagrant playbook
#==========================================================
- hosts: default
  sudo: true
  roles:
    - role: user
    - role: essentials
    - role: nodejs
    - role: postgresql
    - role: ruby
  tasks:
    - include: tasks/vagrant_settings.yml
"
