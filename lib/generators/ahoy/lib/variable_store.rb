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

    def self.clear!
      FileUtils.rm(Ahoy::Generator.temp_dir + "variables.yml")
    end
  end
end
