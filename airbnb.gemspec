# encoding: utf-8
$:.unshift File.expand_path('../lib', __FILE__)

require 'airbnb/version'

Gem::Specification.new do |s|
  s.name         = 'airbnb'
  s.version      = Airbnb::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ['Jonathon Storer']
  s.email        = ['jonathon.scott.storer@gmail.com']
  s.homepage     = 'http://github.com/jonstorer/airbnb'
  s.summary      = 'An API wrapper for Airbnb'
  s.description  = 'Fetch Airbnb listings with ease'
  s.files        = Dir['lib/**/*']
  s.require_path = 'lib'
  s.has_rdoc     = false

  s.add_dependency 'hashie',        '>= 2.0.5'
  s.add_dependency 'json',          '>= 1.8.0'
  s.add_dependency 'rest-client',   '>= 1.6.7'
  s.add_dependency 'addressable',   '>= 2.3.5'
  s.add_dependency 'activesupport', '>= 4.0.0'
end
