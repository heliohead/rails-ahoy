require 'ahoy/version'
require 'ahoy'

module Ahoy
  def self.env
    env_yaml = YAML.load(File.open(Rails.root + ".env/#{Rails.env}_env.yml", 'r'))
    env_yaml.each { |k,v| ENV[k.to_s.upcase] = v.to_s } if env_yaml.present?
  end
end
