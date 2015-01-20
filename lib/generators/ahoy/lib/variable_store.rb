require 'generators/ahoy/base'
require 'fileutils'
require 'yaml'

module Ahoy
  class VariableStore
    def self.add_variable(key, value)
      File.open(Ahoy::Generator.temp_dir + "variables.yml", 'a') {|f| f.write("#{key}: #{value}\n") }
    end

    def self.variables
      YAML.load(File.open(Ahoy::Generator.temp_dir + "variables.yml", 'r'))
    end

    def self.mkdir_tmp
      FileUtils.mkdir(Ahoy::Generator.root + '/tmp')
    end

    def self.rm_tmp
      FileUtils.remove_dir(Ahoy::Generator.root + '/tmp')
    end
  end
end
