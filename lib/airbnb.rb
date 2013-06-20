require 'rubygems'
require 'cgi'
require 'json'
require 'httparty'
require 'hashie'

require 'airbnb/version'
require 'airbnb/base'
require 'airbnb/property'

module Airbnb
  def self.config(&block)
    Airbnb::Base.class_eval &block
  end
end
