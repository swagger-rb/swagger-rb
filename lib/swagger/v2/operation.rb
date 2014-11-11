require 'swagger/swagger_object'
require 'swagger/v2/parameter'
require 'swagger/v2/response'
require 'swagger/v2/security_requirement'

module Swagger
  module V2
    # Class representing a Swagger "Operation Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#operationObject Operation Object
    class Operation < SwaggerObject
      extend Forwardable
      def_delegators :parent, :uri_template, :path, :host

      field :summary, String
      field :description, String
      field :operationId, String
      alias_method :operation_id, :operationId
      field :produces, Array[String]
      field :consumes, Array[String]
      field :tags, Array[String]
      field :parameters, Array[Parameter]
      field :responses, Hash[String => Response]
      field :schemes, Array[String]
      field :security, Array[SecurityRequirement]
      field :externalDocs, Object # TODO: ExternalDocumentation class

      def api_title
        root.info.title
      end

      def full_name
        "#{api_title} - #{summary}"
      end

      # The HTTP verb for the operation.
      def verb
        parent.operations.key self
      end

      def signature
        "#{verb.to_s.upcase} #{parent.uri_template}"
      end

      def default_response
        return nil if responses.values.nil?

        # FIXME: Swagger isn't very clear on "normal response codes"
        # In the examples, default is actually an error
        responses['200'] || responses['201'] || responses['default'] || responses.values.first
      end
    end
  end
end
