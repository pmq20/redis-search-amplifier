# -*- encoding : utf-8 -*-
class Redis;module Search;module Amplifier

  # 一些各种类间公用的方法，你懂的 ：）
  module Shared

    # 我们将在类中开一个Mechanize的派对！
    module MechanizeParty
      extend ActiveSupport::Concern
      included do
        attr_reader :agent
        attr_reader :history
      end
      # introduces @agent and @history variables.
      def initialize(opts={})
        @agent = Mechanize.new
        @agent.log = Redis::Search::Amplifier.config.logger
        @agent.user_agent = Redis::Search::Amplifier.config.user_agent
        @agent.open_timeout = Redis::Search::Amplifier.config.open_timeout
        @agent.read_timeout = Redis::Search::Amplifier.config.read_timeout
        @agent.idle_timeout = Redis::Search::Amplifier.config.idle_timeout
        @agent.redirect_ok = :permanent
        @agent.robots = false
        @agent.follow_meta_refresh = true
        @agent.set_proxy(
          Redis::Search::Amplifier.config.proxy.addr,
          Redis::Search::Amplifier.config.proxy.port,
          Redis::Search::Amplifier.config.proxy.user,
          Redis::Search::Amplifier.config.proxy.pass
        ) if Redis::Search::Amplifier.config.proxy.present?
        @history = @agent.history
      end
    end
  end  

  # 这是一个异常类 
  # 表示我们的代码需要改进了！ 
  class ScriptNeedImprovementException < NotImplementedError
  end

  # 又是一个异常类
  # 表示用户提供的数据有问题
  # 不是我们的问题
  class UserDataException < StandardError
  end

end;end;end
