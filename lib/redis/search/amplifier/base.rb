class Redis;module Search;module Amplifier
  
  extend ActiveSupport::Concern
  included do
    alias_method :redis_search_index_create_huacnlee, :redis_search_index_create
    def redis_search_index_create
      redis_search_index_create_huacnlee
      Redis::Search::Amplifier.config.consultants.each do |consultant|
        Resque.enqueue(consultant::Job,self.class.to_s,self.id)
      end
      true
    end
  end
  
end;end;end