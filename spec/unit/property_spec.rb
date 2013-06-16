require 'spec_helper'

describe Airbnb::Property do
  subject { Airbnb::Property }
  before  { stub_get(:path => '/api/v1/listings/search', :file => 'search') }

  its(:count) { should == 21485 }
end

describe Airbnb::Property, '.fetch' do
  subject { Airbnb::Property }
  before  { stub_get(:path => '/api/v1/listings/search', :file => 'search') }

  it 'returns properties' do
    properties = subject.fetch(:page => 1, :per_page => 20 )
    properties.map(&:class).uniq.should =~ [Airbnb::Property]
  end
end

describe Airbnb::Property, 'attributes' do
  subject          { Airbnb::Property.new(attributes) }
  let(:attributes) do
    json = File.read('./spec/fixtures/search.json')
    hash = JSON.parse(json)
    Hashie::Mash.new(hash).listings.first.listing
  end

  before { stub_get(:path => '/api/v1/listings/900691', :file => 'listing-900961') }

  #its(:user)                            { should == '' }
  its(:address)                          { should == 'West 43rd Street, New York, NY 10036, United States' }
  #its(:amenities)                        { should == '' }
  #its(:amenities_ids)                    { should == '' }
  its(:bathrooms)                        { should == 1 }
  its(:bed_type)                         { should == 'Real Bed' }
  its(:bedrooms)                         { should == 1 }
  its(:beds)                             { should == 1 }
  its(:calendar_updated_at)              { should == '3 days ago' }
  its(:cancel_policy)                    { should == 5 }
  its(:cancel_policy_short_str)          { should == 'Strict' }
  its(:cancellation_policy)              { should == 'strict' }
  its(:check_in_time)                    { should == 14 }
  its(:check_out_time)                   { should == 12 }
  its(:city)                             { should == 'New York' }
  its(:country)                          { should == 'United States' }
  its(:country_code)                     { should == 'US' }
  #its(:description)                      { should == '' }
  its(:guests_included)                  { should == 1 }
  its(:hosting_native_currency)          { should == 'USD' }
  its(:hosting_price_native)             { should == 99 }
  #its(:house_rules)                      { should == '' }
  its(:id)                               { should == 900691 }
  its(:instant_bookable)                 { should == false }
  its(:is_location_exact)                { should == true }
  its(:latitude)                         { should == 40.75747813141989 }
  its(:license)                          { should == nil }
  its(:longitude)                        { should == -73.99101412904595 }
  its(:max_nights)                       { should == 30 }
  its(:max_nights_input_value)           { should == 30 }
  its(:min_nights)                       { should == 1 }
  its(:min_nights_input_value)           { should == 1 }
  its(:monthly_price_native)             { should == 4999 }
  its(:name)                             { should == "Times Square, Queen Bed, Big Futon!" }
  its(:native_currency)                  { should == 'USD' }
  its(:neighborhood)                     { should == "Hell's Kitchen" }
  its(:person_capacity)                  { should == 4 }
  #its(:photos)                           { should == '' }
  #its(:picture_captions)                 { should == '' }
  its(:picture_count)                    { should == 15 }
  its(:price)                            { should == 99 }
  its(:price_for_extra_person_native)    { should == 0 }
  its(:price_formatted)                  { should == '$99' }
  its(:price_native)                     { should == 99 }
  its(:property_type)                    { should == 'Apartment' }
  its(:property_type_id)                 { should == 1 }
  #its(:recent_review)                    { should == '' }
  its(:require_guest_phone_verification) { should == false }
  its(:require_guest_profile_picture)    { should == false }
  its(:requires_license)                 { should == false }
  its(:reviews_count)                    { should == 25 }
  its(:room_type)                        { should == 'Entire home/apt' }
  its(:room_type_category)               { should == 'entire_home' }
  its(:security_deposit)                 { should == 150 }
  its(:security_deposit_formatted)       { should == '$150' }
  its(:security_deposit_native)          { should == 150 }
  its(:security_price_native)            { should == 150 }
  its(:smart_location)                   { should == 'New York, NY' }
  its(:square_feet)                      { should == nil }
  its(:state)                            { should == 'NY' }
  its(:user_id)                          { should == 4810767 }
  #its(:user)                             { should == '' }
  its(:weekly_price_native)              { should == nil }
  its(:zipcode)                          { should == '10036' }

  [:small, :medium, :large, :x_large].each do |size|
    it "returns the #{size} #picture_url" do
      subject.picture_url(size).should == "https://a2.muscache.com/pictures/13242220/#{size}.jpg"
    end
  end
end
