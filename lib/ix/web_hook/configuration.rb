require 'singleton'
module IX
  module WebHook

    class Configuration
      include Singleton

      def initialize
        delivery_method :faraday
        header "Content-Type" => "application/json"
        option "verify-ssl" => true
        option "http-method" => :post
      end

      def delivery_method(method = nil, settings =  {})
        return @delivery_method if @delivery_method && method.nil?
        @delivery_method = IX::WebHook::Helper::lookup_delivery_method(method, settings)
      end

      def header(hash = nil)
        @header ||= {}
        return @header if @header && hash.nil?
        hash.each_pair do |k,v|
          @header[k] = v
        end
        @header
      end

      def option(hash = nil)
        @option ||= {}
        return @option if @option && hash.nil?
        hash.each_pair do |k,v|
          @option[k] = v
        end
        @option
      end

    end

  end
end
