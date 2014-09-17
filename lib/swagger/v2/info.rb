module Swagger
  module V2
    class Info < DefinitionSection
      class Contact < DefinitionSection
        section :name, String
        section :url, Swagger::URI
        section :email, String
      end

      class License < DefinitionSection
        required_section :name, String
        section :url, Swagger::URI
      end

      required_section :version, String
      required_section :title, String
      section :description, String
      section :termsOfService, String
      section :contact, Contact
      section :license, License
    end
  end
end
