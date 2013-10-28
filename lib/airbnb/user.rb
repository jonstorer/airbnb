module Airbnb
  class User < Base
    include Lib::Resource

    property :first_name
  end
end
