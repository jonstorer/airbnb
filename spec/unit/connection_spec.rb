require 'spec_helper'

describe Airbnb::Connection do
  let(:connection) { stub('connection') }

  it 'catches ResponseReadErrors and parses the body anyway' do
    error = Mechanize::ResponseReadError.new(stub('error', :message => 'mock error'), stub('response'), stub(:read => '{}'), '/', stub('mech'))
    connection.stubs(:get).raises(error)
    TorPrivoxy::Agent.stubs(:new => connection)
    subject.get('/').should == {}
  end
end
