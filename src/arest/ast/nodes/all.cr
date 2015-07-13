module Arest
  module AST

    # Need to differentiate operators/expressions
    module Nodes

      class Unary < Arest::AST::Node(T)
        def initialize(*args)
        end
      end

      class Nary < Arest::AST::Node(T)

        getter :children

        def initialize(left, *args)
          @children = ([left] + args).flatten
        end
      end

      class BinOp < Arest::AST::Node(T)
        getter :left, :right

        def initialize(left, right)
          @left = left
          @right = right.kind_of?(Field) ? right.set_rfield : Value.new(right)
        end
      end

      macro node_subtypes(klasses, superklass)
      {% for klass in klasses %}
      class {{klass.id.capitalize}} < {{superklass}}; end
      {% end %}
      end

      #[:Eq].each do |node|
       node_subtypes [:Eq], BinOp
      #end

      #[:And, :Or, :All, :Any].each do |klass|
      #  const_set(klass.to_s, Class.new(Nary))
      #end

      #[:Not].each do |klass|
      #  const_set(klass.to_s, Class.new(Unary))
      #end


      class Field < Arest::AST::Node(T)


        getter :key, :field

        def initialize(field)
          @field = field
          @key = :field
        end

        def set_rfield
          @key = :rfield
          self
        end
      end

      class Query < Arest::AST::Node(T)

        getter :root

        def initialize(query)
          @root = query
        end
      end

      class Value < Arest::AST::Node(T)
        getter :value

        def initialize(value)
          @value = value
        end
      end

    end
  end
end
