require 'swagger/swagger_object'

module Swagger
  module V2
    # Class representing a Swagger "Info Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#infoObject Info Object
    class Info < SwaggerObject
      # Class representing a Swagger "Contact Object".
      # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#contactObject Contact Object
      class Contact < SwaggerObject
        # @group Swagger Fields
        field :name, String
        field :url, Swagger::URI
        field :email, String
        # @endgroup
      end

      # Class representing a Swagger "License Object".
      # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#licenseObject License Object
      class License < SwaggerObject
        required_field :name, String
        field :url, Swagger::URI
      end

      required_field :title, String
      field :description, String
      field :termsOfService, String
      field :contact, Contact
      field :license, License
      required_field :version, String
    end
  end
end
