require 'ahoy/version'
require 'ahoy'

module Ahoy
  def self.env
    env_file = YAML.load(File.open(Rails.root + ".env/#{Rails.env}_env.yml", 'r'))
    env_file.each { |k,v| ENV[k.to_s.upcase] = v.to_s } if env_file.present?
  end
end
