module Swagger
  # Class representing a URI. Backed by Addressable::URI.
  # @see http://en.wikipedia.org/wiki/Uniform_resource_identifier
  class URI < String
    attr_reader :uri
    def initialize(string)
      @uri = Addressable::URI.heuristic_parse string
      super
    end
  end
end
