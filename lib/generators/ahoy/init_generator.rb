require 'ahoy/version'
require 'rails/generators'
require 'generators/ahoy/base'
require 'generators/ahoy/lib/variable_store'

module Ahoy
  class InitGenerator < Ahoy::Generator::Base

    def init
      section_divider
      masthead
      section_divider
      generate 'ahoy:deployment'
      section_divider
      # generate 'ahoy:vagrant'
      # section_divider
      puts 'Finalizing...'
      section_divider
      puts 'Finished!'
      Ahoy::VariableStore.clear!
    end


    private

    def section_divider
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
