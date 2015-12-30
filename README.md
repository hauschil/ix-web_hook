# IX::WebHook

[![Code Climate](https://codeclimate.com/github/hauschil/ix-web_hook/badges/gpa.svg)](https://codeclimate.com/github/hauschil/ix-web_hook/badges/gpa.svg)
[![Build Status](https://travis-ci.org/hauschil/ix-web_hook.svg)](https://travis-ci.org/hauschil/ix-web_hook.svg)

Client library for making WebHook calls with exchangeable delivery methods. The purpose of this library is to be similar to the popular mail gem, which supports multiple delivery methods to deliver the mail. One of the most useful features is the option to use tools like letter_opener and letter_opener_web during development.

Currently supported delivery methods are

* Faraday - Uses Faraday to make the WebHook requests
* Console - Outputs all requests to the console
* ...

See [lib/ix/web_hook/delivery_methods](lib/ix/web_hook/delivery_methods).
## Installation

Add this line to your application's Gemfile:

    gem 'ix-web_hook', '~> 0.0.0'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ix-web_hook

## Usage

    require 'ix-web_hook'

### Examples
  ```ruby
  web_hook = IX::WebHook.new(
    url: "http://any.url",
    header: { "custom" => "header" }
    option: {

      "custom" => "option"
      }
    )
  response = web_hook.deliver
  if response.status == 200
    puts "Success: #{response.body}"
  else
    puts "Error: #{response.body}"
  end
  ```

  ```ruby
  web_hook = IX::WebHook.new do
    url "http://any.url"
    header "custom" => "header"
    option "http-method" => :post, "custom" => "option"
  end

  response = web_hook.deliver

  if response.status == 200
    puts "Success: #{response.body}"
  else
    puts "Error: #{response.body}"
  end
  ```

  ```ruby
  response = IX::WebHook.deliver do
    url "http://any.url"
    header "custom" => "header"
    option   "http-method" => :post, "custom" => "option"
  end

  if response.status == 200
    puts "Success: #{response.body}"
  else
    puts "Error: #{response.body}"
  end
  ```


## Configuration

You can configure your webhook defaults using the following block. If you are using Rails, you would normally add this code block in `config/initializers/ix_web_hook.rb`.

    IX::WebHook.configure do |config|
      config.header
      config.option
      config.delivery_method :faraday # :console
    end

Note, that all default configuration can be overwritten in each instance.
## Testing

    rake spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request
