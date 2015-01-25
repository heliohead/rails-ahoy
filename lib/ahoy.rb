require 'ahoy/version'
require 'ahoy'

module Ahoy
  def self.env
    begin
      env_file = File.open(Rails.root + ".env/#{Rails.env}_env.yml", 'r')
    rescue
      if env_file
        env_yaml = YAML.load(env_file)
        env_yaml.each { |k,v| ENV[k.to_s.upcase] = v.to_s } if env_yaml.present?
      end
    end
  end
end
