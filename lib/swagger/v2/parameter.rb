require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Parameter Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#parameterObject Parameter Object
    class Parameter < SwaggerObject
      # @!group Fixed Fields
      field :name, String
      # required_field :in, String
      field :in, String
      field :description, String
      field :required, Swagger::Boolean
      alias_method :required?, :required
      # @!endgroup

      # @!group Body Fields
      field :schema, Schema
      # @!endgroup

      # @!group Non-Body Fields
      field :type, String
      field :format, String
      field :items, Hash # TODO: Items Object
      field :collectionFormat, String
      field :default, Object
      field :allowEmptyValue, Swagger::Boolean
      alias_method :allowEmptyValue?, :allowEmptyValue
      # @!endgroup

      # stolen from https://github.com/jasonh-n-austin/swagger-rb/blob/master/lib/swagger/v2/parameter.rb
      def parse
        # resolve $ref parameters
        schema = clone
        if schema.key?('$ref')
          #  TODO: Make this smarter than just split, assuming local ref
          key = schema.delete('$ref').split('/').last
          model = root.parameters[key]
          schema.merge!(model)
        end

        schema.to_hash
      end

      include DeterministicJSONSchema
    end
  end
end
