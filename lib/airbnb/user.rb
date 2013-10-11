module Airbnb
  class User < Base
    include Lib::Resource
    include Lib::Property

    property :first_name

  end
end
