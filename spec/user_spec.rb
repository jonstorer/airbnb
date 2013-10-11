require 'spec_helper'

describe Airbnb::User do
  subject { Airbnb::User.find(3241277) }
  before  { stub_get(:path => '/api/-/v1/users/3241277', :file => 'user') }

  it { should be_a(Airbnb::User) }

  its(:first_name) { should == 'Kara' }
  its(:id)         { should == 3241277 }
end
