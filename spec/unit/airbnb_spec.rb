require 'spec_helper'

describe Airbnb, '.config' do
  subject { Airbnb }

  before do
    subject.config do
      http_proxy 'http://www.someproxy.com'
    end
  end

  it 'can set the HTTParty class options on Base' do
    subject::Base.default_options[:http_proxyaddr].should == 'http://www.someproxy.com'
  end
end
