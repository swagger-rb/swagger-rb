module Swagger
  module V2
    # A Swagger Schema Object, which is subset of JSON-Schema that's constrainted to be more deterministic.
    # @see https://github.com/swagger-api/swagger-spec/blob/master/versions/2.0.md#schema-object- Schema Object
    # @see http://json-schema.org/ JSON-Schema
    module DeterministicJSONSchema
      # FIXME: yard group doesn't seem to work below

      # @!group Deterministic JSON Schema
      # @!attribute [rw] $ref
      #     JSON-Schema field $ref.
      #     @return String
      # @!attribute [rw] format
      #     JSON-Schema field format.
      #     @return String
      # @!attribute [rw] title
      #     JSON-Schema field title.
      #     @return String
      # @!attribute [rw] description
      #     JSON-Schema field description.
      #     @return String
      # @!attribute [rw] default
      #     JSON-Schema field default.
      #     @return Object
      # @!attribute [rw] multipleOf
      #     JSON-Schema field multipleOf.
      #     @return Object
      # @!attribute [rw] maximum
      #     JSON-Schema field maximum.
      #     @return Numeric
      # @!attribute [rw] exclusiveMaximum
      #     JSON-Schema field exclusiveMaximum.
      #     @return boolean
      # @!attribute [rw] minimum
      #     JSON-Schema field minimum.
      #     @return Numeric
      # @!attribute [rw] exclusiveMinimum
      #     JSON-Schema field exclusiveMinimum.
      #     @return boolean
      # @!attribute [rw] minLength
      #     JSON-Schema field minLength.
      #     @return Integer
      # @!attribute [rw] maxLength
      #     JSON-Schema field maxLength.
      #     @return Integer
      # @!attribute [rw] pattern
      #     JSON-Schema field pattern.
      #     @return Regexp
      # @!attribute [rw] minItems
      #     JSON-Schema field minItems.
      #     @return Integer
      # @!attribute [rw] maxItems
      #     JSON-Schema field maxItems.
      #     @return Integer
      # @!attribute [rw] uniqueItems
      #     JSON-Schema field uniqueItems.
      #     @return boolean
      # @!attribute [rw] maxProperties
      #     JSON-Schema field maxProperties.
      #     @return Integer
      # @!attribute [rw] minProperties
      #     JSON-Schema field minProperties.
      #     @return Integer
      # @!attribute [rw] required
      #     JSON-Schema field required.
      #     @return boolean
      # @!attribute [rw] enum
      #     JSON-Schema field enum.
      #     @return Array[Object]
      # @!attribute [rw] type
      #     JSON-Schema field type.
      #     @return Object
      # @!endgroup

      # @!group Swagger specific extensions
      # @!attribute [rw] discriminator
      #     Swagger Schema field discriminator.
      #     @return String
      # @!attribute [rw] readOnly
      #     Swagger Schema field readOnly.
      #     @return boolean
      # @!attribute [rw] xml
      #     Swagger Schema field xml.
      #     @return Object
      # @!attribute [rw] externalDocs
      #     Swagger Schema field externalDocs.
      #     @return ExternalDocumentation
      # @!attribute [rw] example
      #     Swagger Schema field example.
      #     @return Object
      # @!endgroup

      def self.included(base) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        # Subset of standard JSON schema
        base.field :$ref, String
        base.field :format, String
        base.field :title, String
        base.field :description, String
        base.field :default, Object
        base.field :multipleOf, Numeric
        base.field :maximum, Numeric
        base.field :exclusiveMaximum, Swagger::Boolean
        base.send(:alias_method, :exclusiveMaximum?, :exclusiveMaximum)
        base.field :minimum, Numeric
        base.field :exclusiveMinimum, Swagger::Boolean
        base.send(:alias_method, :exclusiveMinimum?, :exclusiveMinimum)
        base.field :maxLength, Integer
        base.field :minLength, Integer
        base.field :pattern, String
        base.field :maxItems, Integer
        base.field :minItems, Integer
        base.field :uniqueItems, Swagger::Boolean
        base.send(:alias_method, :uniqueItems?, :uniqueItems)
        base.field :maxProperties, Integer
        base.field :minProperties, Integer
        base.field :required, Swagger::Boolean
        base.send(:alias_method, :required?, :required)
        base.field :enum, Array[Object]
        base.field :type, Object

        # Swagger extensions to JSON schema :\
        base.field :discriminator, String
        base.field :readOnly, Swagger::Boolean
        base.field :xml, Object # TODO: Swagger XML object / XML support
        base.field :externalDocs, Object # TODO: ExternalDocumentation class
        base.field :example, Object
      end
    end
  end
end
