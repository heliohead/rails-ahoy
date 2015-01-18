require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class InitGenerator < Ahoy::Generator::Base

    def init
      generate 'ahoy:vagrant'
      generate 'ahoy:ansible'
    end
  end
end
