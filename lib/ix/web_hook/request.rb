module IX
  module WebHook

    class Request
      def initialize(*args, &block)
        delivery_method Configuration.instance.delivery_method.dup
        header Configuration.instance.header.dup
        option Configuration.instance.option.dup
        evaluate_args(*args)
        evaluate_block(block) if block_given?
        self
      end

      def deliver
        delivery_method.deliver(self)
      end

      def delivery_method=(method); delivery_method method; end
      def delivery_method(method = nil, settings =  {})
        return @delivery_method if @delivery_method && method.nil?
        @delivery_method = WebHook::Helper::lookup_delivery_method(method, settings)
      end

      def header=(hash); header(hash); end
      def header(hash = {})
        @header ||= {}
        hash.each_pair do |k,v|
         @header[k] = v
        end
        @header
      end

      def option=(hash); option hash; end
      def option(hash = {})
        @options ||= {}
        hash.each_pair do |k,v|
         @options[k] = v
        end
        @options
      end

      def url=(str); url(str); end
      def url(str = nil)
        @url ||= nil
        return @url if str.nil?
        @url = str
      end

      def body=(str); body(str); end
      def body(str = nil)
        @body ||= ""
        return @body if str.nil?
        @body = str
      end

      private

      def evaluate_args(*args)
        args.each do |arg|
          arg.each_pair do |k,v|
            send(k, v)
          end
        end
      end

      def evaluate_block(block)
        if block.arity == 1
           block.call(self)
        else
          instance_eval(&block) #only inside the instance
        end
      end

    end
  end
end
