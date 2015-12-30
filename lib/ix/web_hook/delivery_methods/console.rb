module IX
  module WebHook
    class DeliveryMethod
      class Console < WebHook::DeliveryMethod
        def initialize(settings = {})
          super(settings)
        end

        def deliver(web_hook)
          puts web_hook.option
          puts web_hook.header
          puts web_hook.body
          IX::WebHook::Response.new(200, web_hook.header, web_hook.body)
        end
      end
    end
  end
end
