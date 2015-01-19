module Ahoy
  module Initialize
    def root
      File.dirname(__FILE__)
    end
  end

  module Generator
    extend Initialize

    class Base < Rails::Generators::Base
      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      private

      def defaults(value)
        puts '-' * 100
        puts "Default: #{value}"
      end
    end
  end
end
