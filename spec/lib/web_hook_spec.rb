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

  describe '#configure' do
    subject {
      IX::WebHook.configure do |config|
      end
    }
  end

end
