require 'redis/search/amplifier/helpers'
require 'redis/search/amplifier/utils'
require 'redis/search/amplifier/shared'

class Redis;module Search;module Amplifier
  
  autoload :Google,   'redis/search/amplifier/google'
  autoload :Baidu,   'redis/search/amplifier/baidu'
  
  class << self
    attr_reader :config
  end
  # self.configure{} 这种配置方法是可重入的
  # 因此不必保证一次性就全部配置完成
  # 以后可以随时修改配置
  @config = OpenStruct.new
  # default values for config
  @config.search_engines = [Redis::Search::Baidu,Redis::Search::Google]
  @config.google_client_id = nil
  @config.google_client_secret = nil
  @config.logger = Logger.new('/dev/null')
  # Length of time to wait until a connection is opened in seconds
  @config.open_timeout = 1
  # Connections that have not been used in this many seconds will be reset.
  # Sets the idle timeout to idle_timeout. The default timeout is 5 seconds. If you experience “too many connection resets”, reducing this value may help.
  @config.idle_timeout = 5
  # Length of time to wait for data from the server
  @config.read_timeout = 1
  @config.timeout = 1
  @config.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20100101 Firefox/12.0"
  # 每页读取多少条记录？这个影响到打开这个页面的速度，
  # 时间太长会超时。所以控制一下。
  @config.proxy = nil
  # If proxy is necessary, you need to provide the following methods to config.proxy object
  # * addr
  # * port
  # * user
  # * pass
  @config.mechanize_per_page = 88

  def self.configure
    yield(@config)
  end

end;end;end

require 'redis/search/amplifier/shared'
require 'redis/search/amplifier/railtie' if defined?(Rails)