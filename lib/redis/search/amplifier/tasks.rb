# require 'resque/tasks'
# will give you the resque tasks

namespace :redis_search do
  desc "Ampify all existing Redis-Search index data"
  task :amplify => :environment do
    tm = Time.now
    count = 0
    puts "redis-search amplifier".upcase.rjust(120)
                       
    puts "-"*120
    puts "Now ampifying all existing Redis-Search index data...".rjust(120)
    puts ""
    Redis::Search::Amplifier.amplifying_models.each do |klass|
      print "[#{klass.to_s}]"
      # todo
      puts ""
    end
    puts ""
    puts "-"*120
    puts "Ampified #{count} index-items  |  Time spend: #{(Time.now - tm)}s".rjust(120)
    puts "Ampify done.".rjust(120)
  end
end
