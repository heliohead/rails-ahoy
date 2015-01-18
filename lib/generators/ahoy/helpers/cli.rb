module Ahoy
  module Helpers
    module Cli
      def prompt(question)
        puts question
        print "> "
        gets.chomp.downcase
      end

      def ask_integer(question)
        response = 0
        until response >= 1
          response = prompt(question).to_i
          puts 'Please enter a number greater than 1' if response < 1
        end
        response
      end

      def ask_boolean(question)
        valid_responses = { yes: true, y: true, no: false, n: false }
        response = nil
        until valid_responses.keys.include?(response)
          response = prompt("#{question} \n#{answers('Yes', 'No')}").to_sym
          puts 'Answer must be Yes or No' unless valid_responses.keys.include?(response)
        end
        valid_responses[response]
      end

      def answers(*answers)
        "Answer: #{answers.join(', ')}"
      end
    end
  end
end
