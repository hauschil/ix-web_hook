module IX
  module WebHook

    class DeliveryMethod
      is_abstract = true
      def initialize(_settings = {}); end
      def deliver(web_hook); end;
    end

  end
end
