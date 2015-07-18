require "./spec_helper"

describe "Farts" do
  # TODO: Write tests

  it "works" do
    e = Arest::Entity.new(:butts)
    e = e.where(e[:bar].eq(10)).and(e[:fas].eq("10"))
    hasher = Arest::Visitors::Hasher.new
    puts e.build

#    false.should eq(true)
  end
end
