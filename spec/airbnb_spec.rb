require 'spec_helper'

describe Airbnb do
  it 'sets the wait time on the connection' do
    Airbnb.config { wait_for 5 }
    Airbnb::Connection.class_eval{ @wait }.should == 5
  end
end
