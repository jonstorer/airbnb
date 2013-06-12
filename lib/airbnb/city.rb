require 'rest_client'

module Airbnb
  class City
    def initialize(permalink)
      @permalink = permalink
    end

    def permalink
      data['city']['permalink']
    end

    def bounds
      data['city']['bounds']
    end

    private

    def data
      @data ||= JSON.parse(RestClient.get("https://www.airbnb.com/locations/#{@permalink}/neighborhood-traits.json", {:accept => :json}))
    end
  end
end
