require "./ast"

module Arest

  class Entity
    def initialize(name)
     @name = name
    end

    def where(query)
      Arest::AST::Nodes::Query.new(query)
    end

    def [](arg)
      Arest::AST::Nodes::Field.new(arg)
    end
  end

end
