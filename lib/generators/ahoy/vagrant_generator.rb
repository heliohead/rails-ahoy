require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class VagrantGenerator < Ahoy::Generator::Base
    def memory
      @memory = ask_integer 'How many Megabytes of memory would you like to allocate to your VM?'
    end

    def cpus
      @cpus = ask_integer 'How many CPUs would you like to allocated?'
    end

    def copy_templates
      template Ahoy::Generator.templates_path + '_Vagrantfile', 'Vagrantfile'
    end
  end
end
