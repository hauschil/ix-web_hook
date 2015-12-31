require 'faraday'
module IX
  module WebHook
    class DeliveryMethod
      class Faraday < WebHook::DeliveryMethod
        def initialize(settings = {})
          super(settings)
        end

        def deliver(web_hook)

          verify_ssl = web_hook.option.delete("verify-ssl")
          http_method = web_hook.option.delete("http-method")
          url = web_hook.url
          ssl_options = { verify: verify_ssl }
          response = handle_faraday_exceptions do
            if http_method == :put
              ::Faraday.new(url: url, ssl: ssl_options).put do |req|
                set_request_data(req, web_hook)
              end
            else
              ::Faraday.new(url: url, ssl: ssl_options).post do |req|
                set_request_data(req, web_hook)
              end
            end
          end

          Response.new(response.status, response.headers, response.body)
        end

        private

        def set_request_data(request, web_hook)
          web_hook.header.each_pair do |k,v|
            request.headers[k] = v
          end
          web_hook.option.each_pair do |k,v|
            request.options[k] = v
          end
          request.body = web_hook.body
        end

        def handle_faraday_exceptions
          response = begin
            yield
          rescue ::Faraday::TimeoutError  => exception
            exception
          rescue ::Faraday::ConnectionFailed => exception
            exception
          end
          response
        end

      end
    end
  end #ActiveWebHook
end
