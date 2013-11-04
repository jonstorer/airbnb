require 'json'
require 'hashie'
require 'rest_client'
require 'addressable/uri'
require 'active_support'
require 'active_support/core_ext/object/to_query'
require 'active_support/core_ext/object/try'
require 'active_support/concern'

require 'airbnb/lib/resource'

require 'airbnb/version'
require 'airbnb/connection'
require 'airbnb/base'
require 'airbnb/user'
require 'airbnb/listing'

module Airbnb

  def self.log(message)
    if defined?(Rails)
      Rails.logger.info "Airbnb: #{message}"
    else
      @logger ||= Logger.new(STDOUT)
      @logger.info "Airbnb: #{message}"
    end
  end

  class RecordIdentifierNotFound < Exception; end
  class RecordNotFound < Exception; end
  class RateLimitReached < Exception; end
  class InvalidDateRange < ArgumentError; end
  class UnderMinimumNights < ArgumentError; end
  class OverPersonCapacity < ArgumentError; end
  class OverMaximumNights < ArgumentError; end
end
