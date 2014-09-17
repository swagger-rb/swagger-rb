module Swagger
  module V2
    class Example
      extend Forwardable
      def_delegator :@raw, :to_s, :inspect

      attr_reader :raw

      def initialize(sample)
        @raw = sample
      end

      def parse(_format = :json)
        return @raw unless @raw.is_a? String

        JSON.parse(@raw)
      end

      def inspect
        @raw.inspect
      end
    end
  end
end
