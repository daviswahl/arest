require "./node_macros"

module Arest
  module AST
    # Need to differentiate operators/expressions
    module Nodes
      module Types
        alias Key = String | Symbol
        alias Primitive = String | Bool | Int64 | Int32 | Float64 | Symbol

        class ValueHash < Hash(Key, Arest::AST::Nodes::Types::Value)
          def []=(key : String | Symbol, value)
            puts key, value
          end
          def merge(other)
            merge(other as ValueHash)
            self
          end
          def merge(other : Hash(Key, Value | Array(Value)))
            other = other as ValueHash
            self[other.first_key] = other.first_value
            puts self
            self 
          end
        end
        alias Value = Primitive | Hash(Key, Value) | Array(Value) | ValueHash
      end
      include Types

      include NodeMacros
      abstract class Unary < Arest::AST::Node
        def children
          @children
        end

        def initialize(@left : Node, *@children : Node)
        end
      end

      abstract class Nary < Arest::AST::Node

        def children
          @children
        end

        def initialize(left : Node, args : Nary | Query | BinOp)
          @children = [left, args].compact
        end
      end


      abstract class BinOp < Arest::AST::Node
        getter :left
        getter :right 
        def initialize(@left : Field, @right : Literal); end

        def initialize(@left : Field, @right : Field)
          right.set_rfield
        end
      end



      node_subtypes({ Eq: "$eq" },  BinOp)
      node_subtypes({ And: "$and", Or: "$or", All: "$all", Any: "$any"}, Nary)
      node_subtypes({ Not: "$not"}, Unary)


      class Field < Arest::AST::Node
        def token
          @key.to_s
        end
        include NodeMacros
        getter :key, :field

        def eq(args : Primitive)
          Arest::AST::Nodes::Eq.new(self, Literal.new(args))
        end
        def eq(args : Field)
          Arest::AST::Nodes::Eq.new(self, args)
        end
        def initialize(field)
          @field = field
          @key = :field
        end

        def set_rfield
          @key = :rfield
        end
      end

      class Query < Arest::AST::Node
        delegate :token, @root 

        getter :root

        def initialize(query)
          @root = query
        end
      end

      class Literal < Arest::AST::Node
        delegate :token, :value

        getter :value
        def initialize(@value : Primitive)
        end
      end

    end
  end
end
