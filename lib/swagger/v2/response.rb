require 'swagger/v2/example'

module Swagger
  module V2
    class Response < DefinitionSection
      section :description, String
      section :schema, Hash # TODO: Schema
      section :headers, Array # [String => String] # TODO: Headers
      section :examples, Hash[Swagger::MimeType => Example]
    end
  end
end
