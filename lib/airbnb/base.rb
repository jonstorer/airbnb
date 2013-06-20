module Airbnb
  class Base
    include HTTParty

    NORMALIZER = Proc.new do |query|
      query.map do |k, v|
        "#{k}=#{::CGI::escape(v) rescue v}"
      end.join('&')
    end

    PARSER = Proc.new do |body|
      JSON.parse(body.to_s) rescue body.to_s
    end

    base_uri 'https://m.airbnb.com/api/v1'
    format :json
    query_string_normalizer NORMALIZER

    parser PARSER

    def get(path)
      Hashie::Mash.new(self.class.get(path))
    end
  end
end
