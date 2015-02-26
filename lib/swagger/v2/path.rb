require 'swagger/swagger_object'
require 'swagger/v2/operation'

module Swagger
  module V2
    # Class representing a Swagger "Path Item Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#pathItemObject Path Item Object
    class Path < SwaggerObject
      extend Forwardable
      def_delegator :parent, :host

      VERBS = [:get, :put, :post, :delete, :options, :head, :patch]
      VERBS.each do | verb |
        field verb, Operation
      end
      field :parameters, Array[Parameter]

      def operations
        VERBS.each_with_object({}) do | v, h |
          operation = send v
          h[v] = operation if operation
        end
      end

      def uri_template
        "#{parent.host}#{parent.base_path}#{path}"
      end

      def path
        parent.paths.key self
      end

      # Iterates over each Path level parameter.
      def each_parameter
        return if parameters.nil?
        parameters.each do | parameter |
          yield parameter
        end
      end
    end
  end
end
