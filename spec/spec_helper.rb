require 'rubygems'
require 'bundler/setup'

require 'webmock/rspec'
require 'mocha/api'
require 'pry'

require 'airbnb'

RSpec.configure do |config|
  config.mock_with :mocha
end

def stub_get(opts)
  data = File.read("./spec/fixtures/#{opts[:file]}.json")
  url  = "https://m.airbnb.com#{opts[:path]}"
  stub_request(:get, url).to_return(:body => data)
end
