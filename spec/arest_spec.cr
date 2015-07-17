require "./spec_helper"

describe Arest do
  # TODO: Write tests

  it "works" do
    e = Arest::Entity.new(:butts)
    e = e.where(e[:bar].eq(e[:bats]).and(e[:fas].eq(10)))
    hasher = Arest::Visitors::Hasher.new
    e.each { |n| n.accept(hasher) }

#    false.should eq(true)
  end
end
