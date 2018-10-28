module Swagger
  # A common interface for building or loading Swagger documents of any version. See subclasses.
  class API < SwaggerObject
    class Converter < Hashie::Mash
      disable_warnings
    end

    def self.build_api(hash)
      version = hash['swaggerVersion'] || hash['swagger']
      major, _minor = version.to_s.split('.')
      case major
      when '2'
        Swagger::V2::API.new hash
      else
        raise ArgumentError, "Swagger version #{version} is not currently supported"
      end
    end

    def initialize(hash)
      @vendor_extensions = {}
      hash.each do |k, v|
        @vendor_extensions[k] = v if k.to_s.start_with? 'x-'
      end
      # HACK: There's got to be a better way, but Dash wasn't working well with strings
      super(Converter.new(hash).to_hash(symbolize_keys: true))
    end
  end
end

require 'swagger/v2/api'
