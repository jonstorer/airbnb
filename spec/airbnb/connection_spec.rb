require 'spec_helper'

describe Airbnb::Connection, '.get' do
  it 'returns json when successful' do
    stub_request(:get, 'https://m.airbnb.com/api/-/v1/').to_return(:body => {}.to_json)
    Airbnb::Connection.get('/').should == {}
  end

  it 'raises a RecordNotFound exception when 404' do
    body = {}.to_json
    stub_request(:get, 'https://m.airbnb.com/api/-/v1/').to_return(:body => body, :status => 404, :headers => { 'Content-Length' => body.size })
    expect { Airbnb::Connection.get('/') }.to raise_error(Airbnb::RecordNotFound)
  end

  it 'raises a RateLimitReached exception when 301' do
    body = {}.to_json
    stub_request(:get, 'https://m.airbnb.com/api/-/v1/').to_return(:body => body, :status => 301, :headers => { 'Content-Length' => body.size })
    expect { Airbnb::Connection.get('/') }.to raise_error(Airbnb::RateLimitReached)
  end
end
