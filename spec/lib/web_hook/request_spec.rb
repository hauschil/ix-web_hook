require 'spec_helper'

describe IX::WebHook::Request do
  let(:request_url) { "http://a.webhook.url" }
  let(:request_body) { "World Hello" }
  let(:request_header) do
    {
      'Content-Type'=>'application/json',
      'request' => 'header'
    }
  end
  let(:request_options) do
    {
      'request' => 'option'
    }
  end
  before {
    stub_request(:post, request_url).
      with(:body => request_body).
      to_return(:status => 200, :body => "", :headers => {})
  }

  describe '#initialize' do
    describe 'with block' do
      subject {
        IX::WebHook::Request.new do |req|
          req.header request_header
          req.option request_options
          req.body request_body
        end
      }
      its(:header) { is_expected.to have_key "request" }
      its(:option) { is_expected.to have_key "request" }
      its(:body) { is_expected.to eq request_body}
    end
  end

  describe '#deliver' do
    describe 'with faraday' do
      subject {
        IX::WebHook::Request.new do |req|
          req.url request_url
          req.body request_body
          req.option "verify-ssl" => false
          req.delivery_method :faraday
        end.deliver
      }

      it { is_expected.to be_an(IX::WebHook::Response)}
      its(:status) { is_expected.to be 200 }
    end

    describe 'with console' do
      subject {
        request = IX::WebHook::Request.new do |req|
          req.body request_body
          req.option request_options
          req.header request_header
          req.delivery_method :console
        end
        request.deliver
      }
      it { expect { subject }.to output.to_stdout}
      it { is_expected.to be_an(IX::WebHook::Response)}
    end

    describe 'with test' do
      subject {
        request = IX::WebHook::Request.new do |req|
          req.body request_body
          req.option request_options
          req.header request_header
          req.delivery_method :test
        end
        request.deliver
        request.delivery_method.web_hooks
      }
      it {
        expect(subject.count).to be 1
        expect(subject.first.header).to have_key "request"
        expect(subject.first.option).to have_key "request"
        expect(subject.first.body).to eq request_body
      }

    end

  end

end
