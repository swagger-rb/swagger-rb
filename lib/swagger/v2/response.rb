require 'swagger/v2/example'

module Swagger
  module V2
    class Response < DefinitionSection
      section :description, String
      section :schema, Swagger::Schema
      section :headers, Array # [String => String] # TODO: Headers
      section :examples, Hash[Swagger::MimeType => Example]

      def status_code
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
