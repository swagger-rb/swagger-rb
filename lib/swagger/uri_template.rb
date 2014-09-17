module Swagger
  class URITemplate < String
    attr_reader :uri_template
    def initialize(string)
      # FIXME: Is it possible to initialize with heuristic parse once?
      @uri_template = Addressable::Template.new string
      super
    end
  end
end
