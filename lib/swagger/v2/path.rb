require 'swagger/v2/api_operation'

module Swagger
  module V2
    class Path < DefinitionSection
      VERBS = [:get, :put, :post, :delete, :options, :head, :patch]

      section :parameters, Array[Parameter]

      VERBS.each do | verb |
        section verb, APIOperation
      end

      def initialize(hash)
        hash[:parameters] ||= []
        super
      end

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
    end
  end
end
