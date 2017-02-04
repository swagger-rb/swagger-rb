require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Security Scheme Object".
    # @see https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securitySchemeObject
    #   Security Scheme Object
    class SecurityScheme < SwaggerObject
      OAUTH2_TYPE = 'oauth'.freeze
      API_KEY_TYPE = 'apikey'.freeze
      FLOW_TYPES_REQUIRING_AUTHORIZATION_URL = %w(implicit accesscode).freeze
      FLOW_TYPES_REQUIRING_TOKEN_URL = %w(password application accesscode).freeze
      # FIXME: Swagger documentation about what's required doesn't seem accurate - OSAuth2 centric?

      # According to docs, all except description are required. Schema and samples don't match.

      # @!group Fixed Fields
      required_field :type, String
      field :description, String

      # Fields required for type apiKey
      field :name, String # , required: :api_key?
      field :in, String # , required: :api_key?

      # Fields required for type oauth2
      field :flow, String # , required: :oauth2?
      field :scopes, Hash # , required: :oauth2?

      # Fields required for oauth 2 for certain flow types
      field :authorizationUrl, String # , required: :requires_authorization_url?
      field :tokenUrl, String # , required: :requires_token_url?
      # @!endgroup

      private

      def oauth2?
        type.to_s.downcase == OAUTH2_TYPE
      end

      def api_key?
        type.to_s.downcase == API_KEY_TYPE
      end

      def requires_authorization_url?
        oauth2? &&
          FLOW_TYPES_REQUIRING_AUTHORIZATION_URL.include?(flow.to_s.downcase)
      end

      def requires_token_url?
        oauth2? && FLOW_TYPES_REQUIRING_TOKEN_URL.include?(flow.to_s.downcase)
      end
    end
  end
end
