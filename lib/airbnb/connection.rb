module Airbnb
  module Connection
    def self.get(path, params = {})
      url = params_to_url(path, params[:query])
      response_string = connection.get(url).body
      response = JSON.parse(response_string) rescue response_string
      case response
      when Hash
        Hashie::Mash.new(response)
      when String
        response
      end
    end

    private

    def self.params_to_url(path, query)
      url = [ "https://m.airbnb.com/api/v1#{path}" ]
      url << query.map{|k,v| "#{k}=#{CGI::escape(v) rescue v}"}.join('&') if query.is_a?(Hash)
      url.compact.join('?')
    end

    def self.connection
      @@connection ||= TorPrivoxy::Agent.new('http://localhost', '', {}) do |agent|
        agent.user_agent_alias = 'Mac Safari'
      end
    end
  end
end
