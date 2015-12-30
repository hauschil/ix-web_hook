require 'spec_helper'

describe IX::WebHook do

  describe 'VERSION' do
    subject { IX::WebHook::VERSION }
    it { is_expected.not_to be_nil }

    subject { IX::WebHook::VERSION::STRING }
    it { is_expected.to be_an(String) }
  end

  describe '#new' do
    subject { IX::WebHook.new }
    it { is_expected.to be_an(IX::WebHook::Request) }
  end


  describe '#delivery_method' do
    describe 'when faraday' do
      let(:delivery_method) { :faraday }
      subject {
        IX::WebHook.delivery_method = delivery_method
      }
      it { is_expected.to be_an(IX::WebHook::DeliveryMethod::Faraday) }
    end
    describe 'when console' do
      let(:delivery_method) { :console }
      subject {
        IX::WebHook.delivery_method = delivery_method
      }
      it { is_expected.to be_an(IX::WebHook::DeliveryMethod::Console) }
    end
    describe 'when test' do
      let(:delivery_method) { :test }
      subject {
        IX::WebHook.delivery_method = delivery_method
      }
      it { is_expected.to be_an(IX::WebHook::DeliveryMethod::Test) }
    end
  end

end
