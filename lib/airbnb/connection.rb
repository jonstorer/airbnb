module Airbnb
  module Connection
    def self.get(path, params = {})
      url = get_url(path, params[:query])
      begin
        response = connection.get(url).body
      rescue Mechanize::ResponseReadError => error
        response = error.force_parse.body
      end
      Hashie::Mash.new(JSON.parse(response)) rescue response
    end

    private

    def self.get_url(path, query)
      url = [ "https://m.airbnb.com/api/v1#{path}" ]
      url << get_query(query)
      url.reject{|part| part.nil? || part.empty?}.join('?')
    end

    def self.get_query(params = {})
      params ||= {}
      query = []
      params.each_pair do |key, value|
        case value
        when Array
          query.concat value.map{|v| ["#{key}[]", v]}
        else
          query << [key, value]
        end

      end
      query.map { |k, v| [ CGI::escape(k.to_s), CGI::escape(v.to_s) ].join('=') }.join('&')
    end

    def self.connection
      @@connection ||= TorPrivoxy::Agent.new('http://localhost', '', {}) do |agent|
        agent.user_agent_alias = 'Mac Safari'
      end
    end
  end
end
