module Swagger
  class URI < String
    attr_reader :uri
    def initialize(string)
      # FIXME: Is it possible to initialize with heuristic parse once?
      @uri = Addressable::URI.heuristic_parse string
      super
    end
  end
end
