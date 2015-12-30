module IX
  module WebHook
    class DeliveryMethod
      class Test < WebHook::DeliveryMethod
        def initialize(settings = {})
          super(settings)
        end

        def deliver(web_hook)
          web_hooks << web_hook
          IX::WebHook::Response.new(200, web_hook.header, web_hook.body)
        end

        def web_hooks
          @web_hooks ||= []
        end

      end
    end
  end
end
