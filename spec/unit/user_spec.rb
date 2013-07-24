require 'spec_helper'

describe Airbnb::User do
  subject { Airbnb::User.find(3241277) }
  before  { stub_get(:path => '/api/v1/users/3241277', :file => 'user') }

  it { should be_a(Airbnb::User) }

  its(:first_name) { should == 'Kara' }
  its(:id)         { should == 3241277 }
end

describe Airbnb::User, '#listings' do
  subject { Airbnb::User.find(3241277) }

  before do
    stub_get(:path => '/api/v1/users/3241277', :file => 'user')
    stub_get(:path => '/api/v1/users/3241277', :file => 'user')
  end

  it 'returns listings the user owns' do
    subject.listings[0].name.should == 'My Listing'
    subject.listings[1].name.should == 'My Other Listing'

  end
end
