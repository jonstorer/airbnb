require 'rest_client'

module Airbnb
  class Trait
    def initialize(params)
      @params = params
    end

    def id
      @params['id']
    end

    def name
      @params['name']
    end
  end
end
