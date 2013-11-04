module Airbnb
  module Connection

    def self.get(path, params = nil)
      uri              = Addressable::URI.new
      uri.host         = 'm.airbnb.com'
      uri.scheme       = 'https'
      uri.path         = "api/-/v1#{path}"
      uri.query        = params.try(:to_query)

      Airbnb.log(uri.to_s)

      response = RestClient.get(uri.to_s, headers) do |response, request, result, &block|
        case response.code
        when 301
          raise RateLimitReached
        when 404
          raise RecordNotFound, response.body
        else
          response
        end
      end
      Hashie::Mash.new(JSON.parse(response.body)) rescue response.body
    end

    private

    # TODO: test
    def self.headers
      { :accept => :json, :user_agent => user_agents.sample }
    end

    # TODO: test
    def self.user_agents
      @user_agents ||= YAML::load_file [ File.dirname(__FILE__), 'config', 'user_agents.yml'].join('/')
    end
  end
end
