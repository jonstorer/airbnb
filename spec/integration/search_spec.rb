require 'spec_helper'

describe Airbnb::City do
  subject { Airbnb::City.new('new-york') }
  before  { stub_get(:path => 'locations/new-york/neighborhood-traits.json', :file => 'neighborhood-traits') }

  its(:permalink) { should == 'new-york' }
  its(:name)      { should == 'New York' }
  its(:id)        { should == 22 }
end

describe Airbnb::City, '#properties' do
  before do
    stub_get(:path => 'locations/new-york/neighborhood-traits.json', :file => 'neighborhood-traits') 
    stub_get(:path => %{search/ajax_get_results.json.*page=1.*}, :file => 'search-1')
  end

  context 'fetching' do
    subject        { Airbnb::City.new('new-york') }
    let(:property) { stub('property') }

    it 'returns properties' do
      Airbnb::Property.stubs(:new => property)
      subject.properties.should == [property, property]
    end
  end

  context 'individual property' do
    subject { Airbnb::City.new('new-york').properties.first }

    its(:id)           { should  == 900691 }
    its(:name)         { should  == "Times Square, Queen Bed, Big Futon!" }
    its(:latitude)     { should  == 40.75747813141989 }
    its(:longitude)    { should  == -73.99101412904595 }
    its(:price)        { should  == 99 }
    its(:review_count) { should  == 24 }
    its(:room_type)    { should  == 'Entire home/apt' }
  end
end
