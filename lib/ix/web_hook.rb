module IX

  module WebHook
    # require 'version'
    # is_versioned
    require 'ix/web_hook/helper'
    # require 'web_hook/version'
    require 'ix/web_hook/configuration'
    require 'ix/web_hook/request'
    require 'ix/web_hook/response'
    require 'ix/web_hook/delivery_method.rb'
    require 'ix/web_hook/delivery_methods/faraday'
    require 'ix/web_hook/delivery_methods/console'
    require 'ix/web_hook/delivery_methods/test'



    def self.new(*args, &blocks)
      Request.new(*args, &blocks)
    end

    def self.deliver(*args, &block)
      web_hook = self.new(args, &block)
      web_hook.deliver
    end

    def self.configure
      yield IX::WebHook::Configuration.instance
    end

  end
end
