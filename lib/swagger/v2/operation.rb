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
      alias operation_id operationId
      field :produces, Array[String] # TODO: Need a lookup that merges w/ API-level field
      field :consumes, Array[String] # TODO: Need a lookup that merges w/ API-level field
      field :tags, Array[String] # TODO: This is an array of tag names, need to handle resolution name -> Tag object
      field :parameters, Array[Parameter] # TODO: Can't decide if default: [] is useful or troublesome
      field :responses, Hash[String => Response]
      field :schemes, Array[String] # TODO: Need a lookup that merges w/ API-level field
      field :security, Array[SecurityRequirement] # TODO: Need a lookup that merges w/ API-level field
      field :externalDocs, Object # TODO: ExternalDocumentation class
      field :deprecated, Boolean

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
        return nil if responses.nil? || responses.values.nil?

        # FIXME: Swagger isn't very clear on "normal response codes"
        # In the examples, default is actually an error
        responses['200'] || responses['201'] || responses['default'] || responses.values.first
      end

      # Iterates over each parameter defined directly on the operation, excluding parameters
      # defined at the API level.
      def each_parameter
        return if parameters.nil?

        parameters.each do |parameter|
          yield parameter
        end
      end

      # Iterates over all parameters defined on this operation or at the API level
      # TODO: Implement all_parameters
    end
  end
end
