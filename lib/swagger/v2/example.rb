module Swagger
  module V2
    # A class to represent example objects in the Swagger schema.
    # Usually used to represent example request or responses.
    # Provides access to both the raw example or a parsed representation.
    class Example
      extend Forwardable
      def_delegator :@raw, :to_s, :inspect

      # The example as it appears in the Swagger document.
      # @return Object the example
      attr_reader :raw

      def initialize(sample)
        @raw = sample
      end

      # The example after it has been parsed to match the +media_type+.
      # @param media_type [String] the target media_type
      # @return [Object] an object according to the +media_type+
      def parse(media_type = 'application/json')
        return @raw unless @raw.is_a? String
        parser = Swagger::MimeType.parser_for(media_type)
        parser.parse(@raw)
      end
    end
  end
end
