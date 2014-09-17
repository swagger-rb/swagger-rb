require 'swagger/v2/parameter'
require 'swagger/v2/response'

module Swagger
  module V2
    class APIOperation < DefinitionSection
      extend Forwardable
      alias_method :path, :parent
      def_delegator :parent, :uri_template

      # required_section :verb, Symbol
      section :summary, String
      section :description, String
      section :operationId, String
      section :produces, Array[String]
      section :consumes, Array[String]
      section :tags, Array[String]
      section :parameters, Array[Parameter]
      section :responses, Hash[String => Response]
      section :schemes, Array[String]

      def initialize(hash)
        hash[:parameters] ||= []
        super
      end

      def host
        path.api.host
      end

      def verb
        parent.operations.key self
      end

      def default_response
        return nil if responses.values.nil?

        responses['default'] || responses.values.first
      end

      # def self.coerce(orig_hash)
      #   fail TypeError, 'Can only coerce from a hash' unless orig_hash.is_a? Hash
      #   top_level_parameters = orig_hash.delete :parameters

      #   new_hash = {
      #     verb: orig_hash.keys.first
      #   }.merge(orig_hash.values.first).merge(parameters: top_level_parameters)

      #   APIOperation.new(new_hash)
      # end

      # def to_hash
      #   base_hash = super
      #   base_hash.delete :verb
      #   { verb => base_hash }
      # end
    end
  end
end
