require 'generators/ahoy/helpers/cli'

module Ahoy
  module Initialize
    def root
      File.dirname(__FILE__)
    end

    def templates_path
      root + '/templates/'
    end
  end

  module Generator
    extend Initialize

    class Base < Rails::Generators::Base
      include Ahoy::Helpers::Cli

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end
    end
  end
end
