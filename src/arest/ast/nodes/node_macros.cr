module Arest
  module AST
    module NodeMacros
      macro node_subtypes(klasses, superklass)
        {% for klass, token in klasses %}
            class {{klass.id.capitalize}} < {{superklass}}
            @@token = {{token}}
            def token
              @@token.to_s
            end
          end

        {% end %}
      end

      macro has_node(klass)
        def {{klass.id}}(args)
          Arest::AST::Nodes::{{klass.id.capitalize}}.new(self, args)
        end
      end
    end
  end
end
