module Swagger
  class DefinitionSection < Hashie::Dash
    include Hashie::Extensions::Coercion

    attr_accessor :parent

    def initialize(hash)
      super
      attach_to_children
    end

    # @api private
    def attach_parent(parent)
      @parent = parent
      attach_to_children
    end

    # @api private
    def attach_to_children # rubocop:disable Metrics/MethodLength
      each_value do |v|
        if v.respond_to? :attach_parent
          v.attach_parent self
        elsif v.respond_to? :each_value
          v.each_value do |sv|
            sv.attach_parent self if sv.respond_to? :attach_parent
          end
        elsif v.respond_to? :each
          v.each do |sv|
            sv.attach_parent self if sv.respond_to? :attach_parent
          end
        end
      end
    end

    # @api private
    # @!macro [new] section
    #   @!attribute [rw] $1
    #     $3
    #     @return [$2]
    def self.section(name, type)
      property name
      coerce_key name, type
    end

    # @api private
    # @!macro [new] section
    #   @!attribute [rw] $1
    #     **Required**. $3
    #     @return [$2]
    def self.required_section(name, type)
      property name, required: true
      coerce_key name, type
    end
  end
end
