require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class AnsibleGenerator < Ahoy::Generator::Base

    def copy_templates
      directory Ahoy::Generator.templates_path + 'ansible', 'config/ansible'
    end
  end
end
