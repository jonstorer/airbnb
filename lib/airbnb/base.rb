class Base
  BASE_URL = 'https://www.airbnb.com'
  DEFAULT_SEARCH_PARAMS = { :search_view   => 1,    :min_bedrooms => 0,
                            :min_bathrooms => 0,    :min_beds     => 0,
                            :page          => 1,    :checkin      => nil,
                            :checkout      => nil,  :guests       => 1,
                            :sort          => 0,    :keywords     => nil,
                            :price_min     => nil,  :price_max    => nil,
                            :per_page      => 21 }

  REQUIRED_SEARCH_PARAMS = DEFAULT_SEARCH_PARAMS.keys + [ :location ]

  private

  def request(path, params = {})
    url     = "#{BASE_URL}/#{path}.json"
    options = { :accept => :json, :params => params }
    Hashie::Mash.new(JSON.parse(RestClient.get(url, options)))
  end

  def fetch(path, params = {})
    request path, DEFAULT_SEARCH_PARAMS.merge(params)
  end
end
