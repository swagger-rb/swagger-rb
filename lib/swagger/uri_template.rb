module Swagger
  # Class representing a URI Template. Backed by Addressable::Template.
  # @see http://tools.ietf.org/html/rfc6570
  class URITemplate < String
    attr_reader :uri_template
    def initialize(string)
      @uri_template = Addressable::Template.new(string)
      super
    end
  end
end
