module Airbnb
  class User < Base
    ATTRIBUTES = [
      :id,
      :first_name
    ]

    def initialize(params)
      ATTRIBUTES.each do |key|
        instance_variable_set("@#{key}", params[key])
      end
    end

    ATTRIBUTES.each do |key|
      define_method key do
        instance_variable_get("@#{key}")
      end
    end

    def self.find(id)
      response = get "/users/#{id}"
      new response.user
    end
  end
end
