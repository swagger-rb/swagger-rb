module Swagger
  # Represents a Swagger Schema Object, a more deterministic subset of JSON Schema.
  # @see https://github.com/wordnik/swagger-spec/blob/master/versions/2.0.md#schema-object- Schema Object
  # @see http://json-schema.org/ JSON Schema
  class Schema < Hashie::Mash
    disable_warnings

    include Attachable
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::DeepFind
    attr_accessor :parent

    def initialize(hash, default = nil)
      super
      attach_to_children
    end

    def parse
      schema = clone
      if schema.key?('$ref')
        key = schema.delete('$ref')
        model = root.definitions[key]
        schema.merge!(model)
      end

      count = 0
      until schema.refs_resolved?
        raise 'Could not resolve non-remote $refs 5 cycles - circular references?' if count >= 5

        schema.resolve_refs
        count += 1
      end

      schema.to_hash
    end

    protected

    def refs
      deep_find_all('$ref')
    end

    def resolve_refs
      items_and_props = [deep_select('items'), deep_select('properties')].flatten.compact
      items_and_props.each do |item|
        key = item.delete('$ref')
        next if remote_ref? key

        model = root.definitions[key]
        item.merge!(model)
      end
    end

    def refs_resolved?
      return true if refs.nil?

      refs.all? do |ref|
        remote_ref?(ref)
      end
    end

    def remote_ref?(ref)
      ref.match(%r{\A\w+\://})
    end
  end
end
