require 'json-schema'
require 'swagger/v2/info'
require 'swagger/v2/path'

module Swagger
  module V2
    SWAGGER_SCHEMA = File.expand_path 'schemas/swagger/v2.0/schema.json', Swagger::RESOURCES_DIR
    JSON_SCHEMA = File.expand_path 'schemas/json_schema/draft-04.json', Swagger::RESOURCES_DIR

    class APIDeclaration < Swagger::APIDeclaration
      required_section :swagger, Float
      required_section :info, Info
      required_section :paths, Hash[String => Path]
      section :host, Swagger::URITemplate
      section :basePath, Swagger::URITemplate
      section :schemes, Array[String]
      section :consumes, Array[String]
      section :produces, Array[String]
      section :schemas, Hash
      section :definitions, Hash
      section :security, Array
      # FIXME: Doesn't :parameter exist at this level as well?

      attr_reader :apis

      alias_method :base_path, :basePath

      # def initialize(hash)
      #   super
      #   attach_to_apis
      # end

      def apis
        # Perhaps not the best way...
        paths.values.map do | path |
          path.operations.values
        end.flatten
      end

      def uri_template
        # TODO: Can calculated values be safely memoized?
        # TODO: Actual URI Template objects or just strings?
        "#{host}#{basePath}"
      end

      def fully_validate
        # FIXME: fully_validate is ideal, but very slow with the current schema/validator
        errors = JSON::Validator.fully_validate(swagger_schema, to_json)
        fail Swagger::InvalidDefinition, errors unless errors.empty?
        true
      end

      def validate
        JSON::Validator.validate!(swagger_schema, to_json)
      rescue JSON::Schema::ValidationError => e
        raise Swagger::InvalidDefinition, e.message
      end

      private

      def swagger_schema
        @swagger_schema ||= JSON.parse(File.read(SWAGGER_SCHEMA))

        # Offline workaround
        # @swagger_schema = JSON.parse(File.read(SWAGGER_SCHEMA)
        #   .gsub('http://json-schema.org/draft-04/schema', "file://#{SWAGGER_SCHEMA}"))
        # @swagger_schema['$schema'] = 'http://json-schema.org/draft-04/schema#'
        # @swagger_schema
      end

      # def attach_to_apis
      #   @apis ||= Set.new
      #   paths.each do |path, api|
      #     api.path = path
      #     api.parent = self
      #     @apis << api
      #   end
      # end
    end
  end
end
