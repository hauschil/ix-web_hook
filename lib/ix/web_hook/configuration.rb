require 'singleton'
module IX
  module WebHook

    class Configuration
      include IX::WebHook::DSL

      def self.instance(*args, &block)
        @@instance ||= Configuration.new(*args, &block)
      end

      def initialize(*args, &block)
        delivery_method :faraday
        header 'Content-Type' => 'application/json'
        option 'verify-ssl' => true
        option 'http-method' => :post
        body ''
        url ''
        evaluate_args(*args) if args
        evaluate_block(block) if block_given?
        self
      end

    end

  end
end
