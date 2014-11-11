require 'swagger/swagger_object'
require 'swagger/v2/deterministic_json_schema'
require 'swagger/v2/info'
require 'swagger/v2/path'
require 'swagger/v2/tag'
require 'swagger/v2/security_scheme'
require 'swagger/v2/security_requirement'
require 'json-schema'

module Swagger
  # Module containing classes that handle version 2 of the Swagger specification.
  # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md Swagger Specification 2.0
  module V2
    SWAGGER_SCHEMA = File.expand_path 'schemas/swagger/v2.0/schema.json', Swagger::RESOURCES_DIR
    JSON_SCHEMA = File.expand_path 'schemas/json_schema/draft-04.json', Swagger::RESOURCES_DIR

    # Class representing the top level "Swagger Object"
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#swagger-object- Swagger Object
    class API < Swagger::API
      # @group Swagger Fields
      required_field :swagger, String
      required_field :info, Info
      field :host, Swagger::URITemplate
      field :basePath, Swagger::URITemplate
      field :schemes, Array[String]
      field :consumes, Array[String]
      field :produces, Array[String]
      required_field :paths, Hash[String => Path]
      field :definitions, Hash[String => Schema]
      field :parameters, Hash[String => Parameter]
      field :responses, Hash[String => Response]
      field :securityDefinitions, Hash[String => SecurityScheme]
      field :security, Array[SecurityRequirement]
      # TODO: This is actually an array of tag names, not Tag objects, need to handle relation
      field :tag, Array[String]
      field :externalDocs, Object # TODO: ExternalDocs class
      # @endgroup

      alias_method :base_path, :basePath

      # All operations under all paths
      # @return [Array<Operation>]
      def operations
        # Perhaps not the best way...
        paths.values.map do | path |
          path.operations.values
        end.flatten
      end

      # A complete (including host) URI Template for the basePath.
      # @return [Swagger::URITemplate]
      def uri_template
        Swagger::URITemplate.new("#{host}#{basePath}")
      end

      # Validates this object against the Swagger specification and returns all detected errors.
      # Slower than {#validate}.
      # @return [true] if the object fully complies with the Swagger specification.
      # @raise [Swagger::InvalidDefinition] if any errors are found.
      def fully_validate
        # NOTE: fully_validate is ideal, but very slow with the current schema/validator
        errors = JSON::Validator.fully_validate(swagger_schema, to_json)
        fail Swagger::InvalidDefinition, errors unless errors.empty?
        true
      end

      # Validates this object against the Swagger specification and returns the first detected error.
      # Faster than {#fully_validate}.
      # @return [true] if the object fully complies with the Swagger specification.
      # @raise [Swagger::InvalidDefinition] if an error is found.
      def validate
        JSON::Validator.validate!(swagger_schema, to_json)
      rescue JSON::Schema::ValidationError => e
        raise Swagger::InvalidDefinition, e.message
      end

      private

      def swagger_schema
        @swagger_schema ||= JSON.parse(File.read(SWAGGER_SCHEMA))

        # FIXME: Swagger should be able to parse offline. Blocked by json-schema.
        # Offline workaround
        # @swagger_schema = JSON.parse(File.read(SWAGGER_SCHEMA)
        #   .gsub('http://json-schema.org/draft-04/schema', "file://#{SWAGGER_SCHEMA}"))
        # @swagger_schema['$schema'] = 'http://json-schema.org/draft-04/schema#'
        # @swagger_schema
      end
    end
  end
end
