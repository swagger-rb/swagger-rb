require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Parameter Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#parameterObject Parameter Object
    class Parameter < SwaggerObject
      # @!group Fixed Fields
      required_field :name, String
      # required_field :in, String
      field :in, String
      field :description, String
      field :required, Object # FIXME: Should be a boolean
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
      # @!endgroup

      # @!group Deterministic JSON Schema
      field :default, Object
      field :maximum, Numeric
      field :exclusiveMaximum, String # FIXME: boolean
      field :minimum, Numeric
      field :exclusiveMinimum,  String # FIXME: boolean
      field :maxLength, Integer
      field :minLength, Integer
      field :pattern, String
      field :maxItems,  Integer
      field :minItems,  Integer
      field :uniqueItems, String # FIXME: boolean
      field :enum,  Array[Object]
      field :multipleOf,  Numeric
      # @!endgroup
    end
  end
end
