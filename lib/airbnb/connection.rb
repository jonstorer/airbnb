module Airbnb
  module Connection
    def self.get(path, params = {})
      uri              = Addressable::URI.new
      uri.host         = 'm.airbnb.com'
      uri.scheme       = 'https'
      uri.path         = "api/v1#{path}"
      uri.query        = params[:query].try(:to_query)
      response = RestClient.get(uri.to_s).body
      Hashie::Mash.new(JSON.parse(response)) rescue response
    end
  end
end
