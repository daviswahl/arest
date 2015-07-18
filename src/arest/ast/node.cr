module Arest
  module AST
    abstract class Node
      #include Enumerable(T)
    abstract def token

      def accept(visitor : Visitor)
        visitor.visit(self)
      end
      
      def each(&blk : Arest::AST::Node ->_)
        visitor = Arest::Visitors::Traverse.new(&blk)
        accept(visitor)
      end

      def self.visitor_prefix
        ancestors[1].to_s.split("::").last.downcase + "_%s"
      end

      def self.visitor_name
        format(visitor_prefix, name.split("::").last.downcase)
      end

      def any *right
        Nodes::Any.new(self, *right)
      end

      def all *right
        Nodes::All.new(self, *right)
      end

      def or *right
        Nodes::Or.new(self, *right)
      end

      def and right : Arest::AST::Node
        Nodes::And.new(self, right)
      end
      alias_method :where, :and

      def build
        hasher = Arest::Visitors::Hasher.new
        each do |node|
          hasher.visit(node)
        end
      end

      def to_json
        build.to_json
      end
    end
  end
end
