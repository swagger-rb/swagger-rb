require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Security Scheme Object".
    # @see https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securitySchemeObject
    #   Security Scheme Object
    class SecurityScheme < SwaggerObject
      # FIXME: Swagger documentation about what's required doesn't seem accurate - OSAuth2 centric?

      # According to docs, all except description are required. Schema and samples don't match.

      # @!group Fixed Fields
      required_field :type, String
      required_field :description, String
      field :name, String
      field :in, String
      field :flow, String
      field :authorizationUrl, String
      field :tokenUrl, String
      field :scopes, Hash
      # @!endgroup
    end
  end
end
