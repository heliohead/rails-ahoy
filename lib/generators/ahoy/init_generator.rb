require 'ahoy/version'
require 'rails/generators'
require 'generators/ahoy/base'

module Ahoy
  class InitGenerator < Ahoy::Generator::Base

    def init
      divider
      masthead
      divider
      generate 'ahoy:ansible'
      divider
      generate 'ahoy:vagrant'
       divider
      generate 'ahoy:deploy'
      divider
      puts 'Finalizing...'
      copy_env_vars_file
      divider
      puts 'Finished!'
    end

    private

    def copy_env_vars_file
      template '_env_vars.yml', 'config/env_vars.yml'
      append_file '.gitignore', 'config/env_vars.yml'
    end

    def divider
      puts '=' * 100
    end

    def masthead
      puts '          ___           ___           ___            ___      '
      puts '         /  /\         /__/\         /  /\          /__/|     '
      puts '        /  /++\        \  \+\       /  /++\        |  |+|     '
      puts '       /  /+/\+\        \__\+\     /  /+/\+\       |  |+|     ' + '      Ahoy!'
      puts '      /  /+/~/++\   ___ /  /++\   /  /+/  \+\      |  |+|     ' + '      Get your Rails app deployed'
      puts '     /__/+/ /+/\+\ /__/\  /+/\+\ /__/+/ \__\+\  ___|__|+|     '
      puts '     \  \+\/+/__\/ \  \+\/+/__\/ \  \+\ /  /+/ /__/+++++\     ' + "      v.#{Ahoy::VERSION}"
      puts '      \  \++/       \  \++/       \  \+\  /+/  \__\~~~~++\    '
      puts '       \  \+\        \  \+\        \  \+\/+/         \  \+\   '
      puts '        \  \+\        \  \+\        \  \++/           \  \+\  '
      puts '         \__\/         \__\/         \__\/             \__\/  '
      puts
    end
  end
end
