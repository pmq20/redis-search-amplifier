class Redis;module Search;module Amplifier

  class GoogleTranslator
    extend Helpers::Config
    include Helpers::Config
    class Job
      @queue = :redis_search_amplifier
      def self.perform(klass,id)
        p 'todo'
      end
    end
    
  end
  
end;end;end