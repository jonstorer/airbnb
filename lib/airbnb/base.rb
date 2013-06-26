module Airbnb
  class Base
    def get(*args)
      Connection.get *args
    end

    def self.get(*args)
      Connection.get *args
    end
  end
end
