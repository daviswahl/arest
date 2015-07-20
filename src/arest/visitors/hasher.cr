module Arest
  module Visitors

    class Hasher < Visitor
      include Arest::AST::Nodes::Types

      def to_json
        @hash
      end

      def data
        @hash 
      end

      def visit(o : Arest::AST::Nodes::Literal) : ValueHash
        h = ValueHash.new
        h["value"] = o.value
        h
      end

      def visit(o : Arest::AST::Nodes::Field) : ValueHash
        h = ValueHash.new
        h[o.key] = o.field 
        h
      end

      def visit(o : Arest::AST::Nodes::Nary) :  ValueHash
        h = ValueHash.new
        children = o.children.inject(ValueHash.new) do |acc, x| 
          puts x.inspect
          acc.merge(visit(x))
          acc
        end
        #h[o.token] = children  
        puts h.inspect
        h
      end

      def visit(o : Arest::AST::Nodes::BinOp) :  ValueHash
        h = ValueHash.new
        h.merge visit(o.left)
        h.merge visit(o.right)
        #puts r.inspect

        h["$op"] = o.token
        h
      end

      def visit(o : Arest::AST::Nodes::Unary) : ValueHash
         { "$not" => o.children.map{|x| visit x } } as Value
      end

      def visit(o : Arest::AST::Nodes::Query) : ValueHash
        h = ValueHash.new
        h.merge(visit o.root)
        h
      end
    end
  end

end
