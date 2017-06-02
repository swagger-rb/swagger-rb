module Swagger
  # A class that represents an Object defined in the Swagger specification.
  # Provides methods for defining fields in the object.
  class SwaggerObject < Hashie::Dash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::IndifferentAccess
    include Swagger::Attachable

    CUSTOM_PROPERTY_PREFIX = /^x\-/

    # Swagger allows any properties starting with `x-`
    def self.property?(name)
      super(name) || name.to_s =~ CUSTOM_PROPERTY_PREFIX
    end

    attr_accessor :parent

    # @api private
    # Initializes a Swagger object, using Hashie::Dash,
    # and attaches to children objects so navigation via +parent+
    # and +root+ is possible.
    def initialize(hash)
      super
      attach_to_children
    end

    # @api private
    # @!macro [attach] field
    #   @!attribute [rw] $1
    #     Swagger field $1. $3
    #     @return [$2]
    # Defines a Swagger field on a class.
    def self.field(name, type, opts = {})
      property name, opts
      coerce_key name, type
    end

    # @api private
    # @!macro [attach] required_field
    #   @!attribute [rw] $1
    #     **Required** Swagger field $1. $3
    #     @return [$2]
    # Defines a required Swagger field on a class.
    def self.required_field(name, type, opts = {})
      opts[:required] = true
      field(name, type, opts)
    end
  end
end
