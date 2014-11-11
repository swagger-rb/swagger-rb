require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Security Requirement Object".
    # @see https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#securityRequirementObject
    #   Security Requirement Object
    class SecurityRequirement < Hashie::Mash
      # TODO: Need proper constraints, but coercion is tricky
    end
  end
end
