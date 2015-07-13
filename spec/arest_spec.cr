require "./spec_helper"

describe Arest do
  # TODO: Write tests

  it "works" do
    e = Arest::Entity.new(:butts)
    e.where(e[:bar].eq(e[:bats]))
    puts e.inspect
#    false.should eq(true)
  end
end
