module IX
  module WebHook
    class Helper
      def self.lookup_delivery_method(method, settings= {})
        case method.is_a?(String) ? method.to_sym : method
        when :faraday
          ::IX::WebHook::DeliveryMethod::Faraday.new(settings)
        when :console
          ::IX::WebHook::DeliveryMethod::Console.new(settings)
        when :test
          ::IX::WebHook::DeliveryMethod::Test.new(settings)
        else
          method
        end
      end
    end
  end

end
