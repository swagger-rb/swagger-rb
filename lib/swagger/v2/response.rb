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

      # stolen/adapted from https://github.com/jasonh-n-austin/swagger-rb/blob/master/lib/swagger/v2/parameter.rb
      def parse
        # resolve $ref parameters
        schema = clone
        if schema.key?('$ref')
          #  TODO: Make this smarter than just split, assuming local ref
          key = schema.delete('$ref').split('/').last
          model = root.responses[key]
          schema.merge!(model)
        end

        schema.to_hash
      end

    end
  end
end
