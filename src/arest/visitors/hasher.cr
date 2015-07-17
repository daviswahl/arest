module Arest
  module Visitors

    class Hasher < Visitor
      require "json"

      def to_json
        @hash.to_json
      end

      def data
        @hash
      end

      def visit(o : Arest::AST::Node)
        puts o.inspect
      end
      def visit(o : Arest::AST::Nodes::Field)
       puts o.inspect 
      end

      def visit(o : Arest::AST::Nodes::Value)
        @hash = { rvalue:  o.value }
      end

      def visit(o : Arest::AST::Nodes::Eq)
        puts o.inspect 
      end

      def visit_nary_and o, children
        @hash = { "$and" => children }
      end

      def visit_nary_or o, children
        @hash = { "$or" => children }
      end

      def visit_nary_all o, children
        @hash = { "$all" => children }
      end

      def visit(o : Arest::AST::Nodes::Query)
       puts o.inspect
      end
    end
  end

end
