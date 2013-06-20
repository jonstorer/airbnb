module Airbnb
  class Base
    include HTTParty
    base_uri 'https://m.airbnb.com/api/v1'
    format :json
    query_string_normalizer proc { |query|
      query.map { |k, v| "#{k}=#{ ::CGI::escape(v) rescue v}" }.join('&')
    }

    parser lambda { |body, _| JSON.parse(body.to_s) rescue body.to_s }

    def get(path)
      Hashie::Mash.new(self.class.get(path))
    end
  end
end
