module Arest
  module Visitors
    class Traverse < Visitor

      def visit(o : Arest::AST::Nodes::Field, &blk : Arest::AST::Node ->)
        yield (o)
      end

      def visit(o : Arest::AST::Nodes::Value, &blk : Arest::AST::Node ->)
        yield o
      end

      def visit(o : Arest::AST::Nodes::Query, &blk : Arest::AST::Node ->)
        o.root.accept(self, &blk)
        blk.call o
      end

     # def visit(o : Arest::AST::Nodes::Unary, &blk)
     #   yield o
     # end

      def visit(o : Arest::AST::Nodes::Nary, &blk : Arest::AST::Node ->)
        o.children.map { |child| child.accept(self, &blk) }
        blk.call(o)
      end

      def visit(o : Arest::AST::Nodes::BinOp, &blk : Arest::AST::Node ->)
        o.left.accept(self, &blk)
        o.right.accept(self, &blk)
        blk.call(o)
      end
    end
  end
end
