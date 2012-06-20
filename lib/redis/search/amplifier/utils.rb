# -*- encoding : utf-8 -*-
class Redis;module Search;module Amplifier
  
  module Utils
    # To execute the block code in a exception-free manner
    # all exceptions are sent to the logger on the error level for inspection.
    # returns nil on error

    # 让真正的汉字“出来”
    def self.getout_from(se,src_charset)
      begin
        return se.encode('utf-8',src_charset, :invalid => :replace, :undef => :replace, :replace => "") if src_charset!='utf-8'
      rescue => e
        Redis::Search::Amplifier.config.logger.error "#{e}"
      end
      return se
    end


    def self.safely(&block)
      return yield
    rescue => e
      Redis::Search::Amplifier.config.logger.error "#{e}"
      return nil
    end
    def self.get_parser(page)
      if page.encoding_error?
        return Nokogiri::HTML( self.getout_from(page.body,page.encoding) )
      else
        return page.parser
      end
    end

    # Adopt some methods from the front-end JQuery lib
    class JQuery
      #c.f. http://api.jquery.com/jQuery.ajax/
      def JQuery.ajax(settings={})
        settings = settings.with_indifferent_access
        config = Redis::Search::Amplifier.config
        resource = RestClient::Resource.new(settings[:url], :open_timeout => config.open_timeout, :timeout => config.timeout)
        settings[:accepts] ||= :json
        begin
          if 'POST'==settings[:type]
            data = settings[:data]
            data = settings[:data].to_json if :json==settings[:contentType]
            response = resource.post(data, :content_type => settings[:contentType], :accept => settings[:accepts])
          elsif 'GET'==settings[:type]
            response = resource.get({:accept => settings[:accepts]})
          else
            raise 'Note: Other HTTP request methods, such as PUT and DELETE, can also be used here, but they are not supported by me yet.'
          end
          config.logger.debug "#{response}"
          return response
        rescue => e
          config.logger.error "#{e}"
          return nil
        end
      end
    end
    # end of JQuery
  end  

end;end;end
