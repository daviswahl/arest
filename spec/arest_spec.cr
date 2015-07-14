require "./spec_helper"

describe Arest do
  # TODO: Write tests

  it "works" do
    e = Arest::Entity.new(:butts)
    e = e.where(e[:bar].eq(e[:bats]))
    e.each { |n| n.inspect  }

#    false.should eq(true)
  end
end
