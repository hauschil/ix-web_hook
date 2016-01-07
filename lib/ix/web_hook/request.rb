module IX
  module WebHook

    class Request
      include ::IX::WebHook::DSL

      def initialize(*args, &block)
        delivery_method Configuration.instance.delivery_method.dup
        header Configuration.instance.header.dup
        option Configuration.instance.option.dup
        url Configuration.instance.url.dup
        body Configuration.instance.body.dup
        evaluate_args(*args)
        evaluate_block(&block) if block_given?
        self
      end

      def deliver
        delivery_method.deliver(self)
      end

    end
  end
end
