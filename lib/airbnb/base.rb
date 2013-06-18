module Airbnb
  class Base
    include HTTParty
    base_uri 'https://m.airbnb.com/api/v1'
    format :json
    query_string_normalizer Proc.new do |query|
      query.map do |key, value|
        pair = [key]
        pair << value.is_a?String ? SGI::escape(value) : value
        pair.join('=')
      end.join('&')
    end

    parser lambda { |body, _| JSON.parse(body.to_s) rescue body.to_s }

    def get(path)
      Hashie::Mash.new(self.class.get(path))
    end
  end
end
