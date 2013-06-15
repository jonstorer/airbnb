# encoding: utf-8
$:.unshift File.expand_path('../lib', __FILE__)

require 'airbnb'

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
end
