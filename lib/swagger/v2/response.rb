require 'swagger/swagger_object'
require 'swagger/v2/example'
require 'swagger/v2/header'

module Swagger
  module V2
    # Class representing a Swagger "Response Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#responseObject Response Object
    class Response < SwaggerObject
      field :description, String
      field :schema, Swagger::Schema
      field :headers, Hash[String => Header] # TODO: Headers
      field :examples, Hash[Swagger::MimeType => Example]

      def status_code
        # FIXME: swagger-spec needs a defined way to define codes
        code = parent.responses.key self
        code = '200' if code == 'default'
        code.to_i
      rescue
        # TODO: Warning?
        200
      end
    end
  end
end
