class Redis;module Search;module Amplifier
  
# 方便您在子模块中方便地使用里全局config，说白了就是一个快捷方式。
# Usage:
#   extend Redis::Search::Amplifier::Helpers::Config
#   include Redis::Search::Amplifier::Helpers::Config
module Helpers
  module Config
    def config
      Redis::Search::Amplifier.config
    end
    def logger
      Redis::Search::Amplifier.config.logger
    end
  end
end

end;end;end