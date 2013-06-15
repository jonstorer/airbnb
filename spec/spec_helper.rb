require 'rubygems'
require 'bundler/setup'

require 'webmock/rspec'
require 'mocha/api'

require 'airbnb'

RSpec.configure do |config|
  config.mock_with :mocha
end

def stub_get(opts)
  opts = opts.merge(:format => 'json')
  data = File.read("./spec/fixtures/#{opts[:file]}.json")
  url  = %r{https://www.airbnb.com/#{opts[:path]}}
  stub_request(:get, url).to_return(:body => data)
end
