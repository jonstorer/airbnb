module Airbnb
  class Base
    def get(*args)
      Connection.get *args
    end

    def self.get(*args)
      Connection.get *args
    end

    private

    def self.sanatize(options, whitelist = [])
      blacklist_keys = options.keys - whitelist
      blacklist_keys.each {|key| options.delete(key) }
      options
    end
  end
end
