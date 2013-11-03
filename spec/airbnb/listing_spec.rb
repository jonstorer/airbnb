require 'spec_helper'

describe Airbnb::Listing do
  subject { Airbnb::Listing }
  before  { stub_get(:path => '/api/-/v1/listings/search?items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search') }
  its(:count) { should == 21485 }
end

describe Airbnb::Listing, '.find' do
  subject { Airbnb::Listing.find(900691) }
  before  { stub_get(:path => '/api/-/v1/listings/900691', :file => 'listing-900961') }

  its(:id)    { should == 900691 }
  its(:class) { should == Airbnb::Listing }
end

describe Airbnb::Listing, '.fetch' do
  subject { Airbnb::Listing }

  it 'returns properties' do
    stub_get(:path => '/api/-/v1/listings/search?items_per_page=20&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:page => 1, :per_page => 20)
    properties.map(&:class).uniq.should =~ [Airbnb::Listing]
  end

  it 'can search with location' do
    stub_get(:path => '/api/-/v1/listings/search?items_per_page=10&location=West+LA&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:location => 'West LA')
    properties.all?.should be_true
  end

  it 'can search by number of guests' do
    stub_get(:path => '/api/-/v1/listings/search?items_per_page=10&location=&number_of_guests=10&offset=0', :file => 'search')
    properties = subject.fetch(:number_of_guests => 10)
    properties.all?.should be_true
  end

  it 'can search by page' do
    stub_get(:path => '/api/-/v1/listings/search?items_per_page=10&location=&number_of_guests=1&offset=620', :file => 'search')
    properties = subject.fetch(:page => 63)
    properties.all?.should be_true
  end

  it 'can search by per_page' do
    stub_get(:path => '/api/-/v1/listings/search?items_per_page=63&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:per_page => 63)
    properties.all?.should be_true
  end

  it 'can search by checkin_in & checkin_out' do
    stub_get(:path => '/api/-/v1/listings/search?checkin_in=2014-03-03&checkin_out=2014-04-03&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:checkin_in => Date.parse('3/3/2014'), :checkin_out => Date.parse('3/4/2014'))
    properties.all?.should be_true
  end

  it 'can search by room_types' do
    stub_get(:path => '/api/-/v1/listings/search?room_types%5B%5D=Private+room&room_types%5B%5D=Shared+room&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:room_types => ['Private room', 'Shared room'])
    properties.all?.should be_true
  end

  it 'can search by min_beds' do
    stub_get(:path => '/api/-/v1/listings/search?min_beds=2&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:min_beds => 2)
    properties.all?.should be_true
  end

  it 'can search by min_bedrooms' do
    stub_get(:path => '/api/-/v1/listings/search?min_bedrooms=2&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:min_bedrooms => 2)
    properties.all?.should be_true
  end

  it 'can search by min_bathrooms' do
    stub_get(:path => '/api/-/v1/listings/search?min_bathrooms=2&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:min_bathrooms => 2)
    properties.all?.should be_true
  end

  it 'can search by price_min' do
    stub_get(:path => '/api/-/v1/listings/search?price_min=20&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:price_min => 20)
    properties.all?.should be_true
  end

  it 'can search by price_max' do
    stub_get(:path => '/api/-/v1/listings/search?price_max=200&items_per_page=10&location=&number_of_guests=1&offset=0', :file => 'search')
    properties = subject.fetch(:price_max => 200)
    properties.all?.should be_true
  end
end

describe Airbnb::Listing, '#id' do
  subject { Airbnb::Listing.new }
  it 'raises an error if the id is missing' do
    expect { subject.id }.to raise_error(Airbnb::RecordIdentifierNotFound)
  end
end

describe Airbnb::Listing do
  subject { Airbnb::Listing.new(attributes) }

  let(:attributes) do
    Hashie::Mash.new(JSON.parse(File.read('./spec/fixtures/search.json'))).listings.first.listing
  end

  before do
    stub_get(:path => '/api/-/v1/listings/900691', :file => 'listing-900961')
  end

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
  its(:lat)                              { should == 40.75747813141989 }
  its(:license)                          { should == nil }
  its(:lng)                              { should == -73.99101412904595 }
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
end

describe Airbnb::Listing, '#available?' do
  let(:listing)  { Airbnb::Listing.new(:id => '1234', :max_nights => 4, :min_nights => 2, :person_capacity => 2) }
  let(:checkin)  { Date.parse('11/12/2013') }
  let(:checkout) { Date.parse('13/12/2013') }

  context 'when the listing is available' do
    subject { listing.available?(checkin, checkout, 2) }

    before do
      stub_get(:path => "/api/-/v1/listings/1234/available?checkin=#{checkin.strftime('%Y-%m-%d')}&checkout=#{checkout.strftime('%Y-%m-%d')}&number_of_guests=2", :file => '1234-available')
    end

    its(:available) { should be_true }
    its(:price)     { should == 52 }
  end

  context 'when the listing is unavailable' do
    subject { listing.available?(checkin, checkout, 2) }

    before do
      stub_get(:path => "/api/-/v1/listings/1234/available?checkin=#{checkin.strftime('%Y-%m-%d')}&checkout=#{checkout.strftime('%Y-%m-%d')}&number_of_guests=2", :file => '1234-unavailable')
    end

    its(:available) { should be_false }
    its(:price)     { should be_nil }
  end

  context 'when using invalid arguments' do
    it 'raises an argument error when the checkin date is after the checkout date' do
      checkin  = Date.parse('14/12/2013')
      checkout = Date.parse('13/12/2013')
      expect { listing.available?(checkin, checkout, 1) }.to raise_error(Airbnb::InvalidDateRange)
    end

    it 'raises an argument error when the number of nights between checkin and checkout is less than the minimum required' do
      checkin  = Date.parse('13/12/2013')
      checkout = Date.parse('14/12/2013')
      expect { listing.available?(checkin, checkout, 1) }.to raise_error(Airbnb::UnderMinimumNights)
    end

    it 'raises an argument error when the number of nights between checkin and checkout is over than the maximum required' do
      checkin  = Date.parse('13/12/2013')
      checkout = Date.parse('23/12/2013')
      expect { listing.available?(checkin, checkout, 1) }.to raise_error(Airbnb::OverMaximumNights)
    end

    it 'raises an argument error when the number of guests is larger than the max' do
      expect { listing.available?(checkin, checkout, 3) }.to raise_error(Airbnb::OverPersonCapacity)
    end
  end
end
