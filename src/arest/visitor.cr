module Arest

  module Visitor

    class VisitorError < Exception; end

    module ClassMethods

      def dispatch_hash
        @@dispatch_hash ||= Hash.new do |h, k|
          h[k] = format("visit_%s", k.visitor_name )
        end
      end

    end

    module InstanceMethods
      def visit node, *args, &blk
        dispatch(node, *args, &blk)
      end

      def dispatch(node, *args, &blk)
        meth = self.class.dispatch_hash[node.class]
        send meth, node, *args, &blk
      rescue e: NoMethodError
        if e.name =~ /^visit_/
          raise VisitorError, "#{self} cannot visit #{node.class.name}, #{meth} undefined"
        else
          raise e
        end
      end
    end

    def self.included(klass)
      klass.extend ClassMethods
      klass.include InstanceMethods
    end
  end
end
