module Airbnb
  class City < Base
    def initialize(permalink)
      @permalink = permalink
    end

    def permalink
      @permalink
    end

    def name
      meta.city.name
    end

    def id
      meta.city.id
    end

    def properties(params = {})
      search(params).properties.map{|property| Airbnb::Property.new(property) }
    end

    private

    def meta
      @meta ||= request("locations/#{@permalink}/neighborhood-traits")
    end

    def search(options = {})
      fetch('search/ajax_get_results', { :location => name }.merge(options))
    end
  end
end
