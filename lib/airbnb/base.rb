class Base
  extend Forwardable
  include HTTParty
  base_uri 'https://m.airbnb.com/api/v1'
  format :json

  def get(path)
    Hashie::Mash.new(self.class.get(path))
  end
end
