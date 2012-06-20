class Redis;module Search;module Amplifier

  class Baidu
    extend Helpers::Config
    include Helpers::Config
    include Shared::MechanizeParty
    class Job
      @queue = :redis_search_amplifier
      def self.perform(klass,id)
        p 'todo'
      end
    end
    
  end

end;end;end