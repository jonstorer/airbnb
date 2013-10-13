module Airbnb
  module Connection

    def self.get(path, params = nil)
      uri              = Addressable::URI.new
      uri.host         = 'm.airbnb.com'
      uri.scheme       = 'https'
      uri.path         = "api/-/v1#{path}"
      uri.query        = params.try(:to_query)

      wait

      response = RestClient.get(uri.to_s).body
      Hashie::Mash.new(JSON.parse(response)) rescue response
    end

    private

    def self.wait
      sleep @wait.to_i
    end

    def self.wait_for(value=nil)
      @wait = value if value
      @wait
    end
  end
end
