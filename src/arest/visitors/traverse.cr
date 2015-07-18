module Arest
  module Visitors

    class Traverse < Visitor
      def blk
        @blk
      end

      def initialize(&blk : Arest::AST::Node -> _)
        @blk = blk
      end
      
      def visit(o : Arest::AST::Nodes::Field)
         blk.call(o)
      end

      def visit(o : Arest::AST::Node)
        raise Exception.new(o.inspect)
      end

      def visit(o : Arest::AST::Nodes::Literal)
        blk.call(o)
      end

      def visit(o : Arest::AST::Nodes::Query)
        visit(o.root)
      end

     # def visit(o : Arest::AST::Nodes::Unary, &blk)
     #   yield o
     # end

      def visit(o : Arest::AST::Nodes::Nary)
        o.children.each { |child| visit child }
        blk.call(o)
      end

      def visit(o : Arest::AST::Nodes::BinOp)
       visit(o.left)
       visit(o.right)
       blk.call o
      end
    end
  end
end
