module Swagger
  module V2
    # Class representing a Swagger "Tag Object".
    # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#tagObject Tag Object
    class Tag < SwaggerObject
      required_field :name, String
      field :description, String
      # TODO: Documentable
    end
  end
end
