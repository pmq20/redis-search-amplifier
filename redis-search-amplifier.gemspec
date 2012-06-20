# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "redis-search-amplifier"
  s.version = "1.0"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Minqi Pan"]
  s.email = ["pmq2001@gmail.com"]
  s.homepage = "https://github.com/pmq20/redis-search-amplifier"
  s.summary = "Amplifies the effectiveness of redis-search via the aid of remote search engines"
  s.description = "Amplifies the effectiveness of redis-search, the High performance real-time search (Support Chinese) index support with Redis for Rails application, via the aid of remote search engines."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency("resque")
  s.add_dependency("activesupport")
  s.add_dependency("redis-search", ">= 0.8.0")
  s.add_dependency("redis", [">= 2.1.1"])

  s.files = Dir.glob("lib/**/*") + %w(README.md LICENSE)
  s.require_path = 'lib'
end