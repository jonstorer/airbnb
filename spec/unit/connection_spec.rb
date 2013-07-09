require 'spec_helper'

describe Airbnb::Connection do
  let(:connection) { stub('connection') }
  let(:error) { Mechanize::ResponseReadError.new(stub('error', :message => 'mock error'), stub('response'), stub('body_io'), '/', stub('mech')) }

  before do
    error.stubs(:force_parse => "{\"user\":{\"id\":1234}}")
    connection.stubs(:get).raises(error)
    TorPrivoxy::Agent.stubs(:new => connection)
  end

  it 'catches ResponseReadErrors and parses the body anyway' do
    subject.get('/').to_hash.should == {'user' => { 'id' => 1234 } }
  end
end
