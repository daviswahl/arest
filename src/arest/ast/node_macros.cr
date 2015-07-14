module Arest
  module AST
    module NodeMacros
      macro node_subtypes(klasses, superklass)
      {% for klass in klasses %}
      class {{klass.id.capitalize}} < {{superklass}}; end
    {% end %}
      end

      macro has_node(klass)
        def {{klass.id}}(*args)
          {{klass.id.capitalize}}.new(*args)
        end
      end
    end
  end
end
