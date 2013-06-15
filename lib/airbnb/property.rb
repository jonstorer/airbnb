module Airbnb
  class Property
    def initialize(params)
      @params = params
    end

    def id
      @params.id
    end

    def name
      @params.name
    end

    def latitude
      @params.lat
    end

    def longitude
      @params.lng
    end

    def room_type
      @params.room_type
    end

    def review_count
      @params.review_count
    end

    def price
      @params.price
    end
  end
end
