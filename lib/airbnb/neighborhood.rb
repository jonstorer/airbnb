require 'rest_client'

module Airbnb
  class Neighborhood
    def initialize(params)
      @params = params
    end

    def id
      @params['id']
    end

    def point
      @params['point']
    end

    def permalink
      @params['permalink']
    end

    def bounds
      @params['bounds']
    end

    def name
      @params['name']
    end

    def traits
      @traits = @params['traits'].map{|t| Airbnb::Trait.new(t)}
    end

    def hosting_count
      @params['hosting_count']
    end
  end
end
