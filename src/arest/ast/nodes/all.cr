require "./node_macros"

module Arest
  module AST
    # Need to differentiate operators/expressions
    module Nodes
      include NodeMacros
      class Unary < Arest::AST::Node
        def initialize(*args)
        end
      end

      class Nary(Field | Value) < Arest::AST::Node

        getter :children

        def initialize(left : Node, args : Node)
          @children = [left, args].compact
        end
      end

      class BinOp < Arest::AST::Node
        getter :left

        def right : Field | Value
          @right
        end

        def initialize(left, right)
          @left = left
          @right = Value.new right
        end

        def initialize(left, right : Field)
          @left = left
          right.set_rfield
          @right = right
        end
      end


      node_subtypes [:Eq], BinOp
      node_subtypes [:And, :Or, :All, :Any], Nary
      node_subtypes [:Not], Unary


      class Field < Arest::AST::Node
        include NodeMacros
        has_node :eq

        getter :key, :field

        def initialize(field)
          @field = field
          @key = :field
        end

        def set_rfield
          @key = :rfield
        end
      end

      class Query < Arest::AST::Node

        getter :root

        def initialize(query)
          @root = query
        end
      end

      class Value(T) < Arest::AST::Node
        getter :value

        def initialize(value )
          @value = value
        end
      end

    end
  end
end
