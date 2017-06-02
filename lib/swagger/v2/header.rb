require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Header Object".
    # @see https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#headerObject Header Object
    class Header < SwaggerObject
      # @!group Fixed Fields
      field :description, String
      field :required, Swagger::Boolean
      alias required? required
      field :type, String
      field :format, String
      field :items, Hash # TODO: Items Object
      field :collectionFormat, String
      field :default, Object
      # @!endgroup

      include DeterministicJSONSchema
    end
  end
end
