require 'rails/generators'
require 'generators/ahoy/base'
require 'generators/ahoy/lib/question_helper'
require 'generators/ahoy/lib/variable_store'
require 'fileutils'

module Ahoy
  class VagrantGenerator < Ahoy::Generator::Base

    def use_vagrant
      question :boolean do
        {
          use_vagrant: 'Would you like to use Vagrant with your project?',
          default: 'No'
        }
      end
    end

    def prompt_user
      if Ahoy::VariableStore.variables['use_vagrant'] == true
        question :string do
          {
            vagrant_memory: 'How many Megabytes of memory would you like to allocate to your VM? [enter for default]',
            default: '2'
          }
        end
        question :string do
          {
            vagrant_cpus: 'How many CPUs would you like to allocated? [enter for default]',
            default: '1'
          }
        end
      else
        puts 'Skipping Vagrant'
        exit
      end
    end

    def copy_files
      copy_file '_database.yml', 'config/database.yml'
    end

    def copy_templates
      template '_Vagrantfile', 'Vagrantfile'
      template 'ansible_templates/playbooks/host_vars/_default.yml', 'config/ansible/playbooks/host_vars/default.yml'
    end

    def append_files
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
