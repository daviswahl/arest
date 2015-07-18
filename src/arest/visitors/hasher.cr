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

      def visit(o : Arest::AST::Nodes::Literal) : Value
        { "value" as Key => o.value as Value}
      end

      def visit(o : Arest::AST::Nodes::Field) : Value
        { o.key as Key  => o.field as Value } 
      end

      def visit(o : Arest::AST::Nodes::Nary) :  Value
        arr = [] of Value
        o.children.each{|x| arr << (visit x) }
        { o.token as Key => arr as Value} as Value
      end

      def visit(o : Arest::AST::Nodes::BinOp) :  Value
        l = visit(o.left)
        r = visit(o.right)
        h = { l.first_key => l.first_value as Value, r.first_key => r.first_value as Value } 
        op = ("$op") as Key
        h[op] = o.token as Value
        h as Value 
      end

      def visit(o : Arest::AST::Nodes::Unary) : Value
         { "$not" => o.children.map{|x| visit x } } as Value
      end

      def visit(o : Arest::AST::Nodes::Query) : Value
        visit o.root
      end
    end
  end

end
