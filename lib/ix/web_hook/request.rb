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
        apply_hash(:@header, hash)
      end

      def option=(hash); option hash; end
      def option(hash = {})
        apply_hash(:@options, hash)
      end

      def url=(str); url(str); end
      def url(str = nil)
        apply_str(:@url, str, nil)
      end

      def body=(str); body(str); end
      def body(str = nil)
        apply_str(:@body, str)
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

      def apply_hash(variable_symbol, hash = nil, default = {})
        local = instance_variable_get(variable_symbol)
        return local if hash.nil?
        local ||= default.dup if default
        hash.each_pair do |k,v|
         local[k] = v
        end
        instance_variable_set(variable_symbol, local)
      end

      def apply_str(variable_symbol, str = nil, default = "")
        local = instance_variable_get(variable_symbol)
        local ||= default.dup if default
        return local if str.nil?
        instance_variable_set(variable_symbol, str)
      end
    end
  end
end
