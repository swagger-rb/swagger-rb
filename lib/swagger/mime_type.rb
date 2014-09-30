require 'mime/types'

module Swagger
  # Class representing Media Types (commonly known as MIME Types).
  # @see http://en.wikipedia.org/wiki/Internet_media_type
  class MimeType < String
    extend Forwardable
    def_delegators :@mime_type, :media_type, :sub_type

    MIME_TYPE_FORMAT = /(\w+)\/(\w+\.)?([\w\.]+)(\+\w+)?\s*(;.*)?/

    COMMON_ALIASES = {
      txt:    'text/plain',
      text:   'text/plain',
      json:   'application/json',
      xml:    'application/xml',
      binary: 'application/octet-stream'
    }

    def initialize(mime_type_name)
      @mime_type_name = mime_type_name.to_s
      @mime_type = MIME::Types[@mime_type_name].first || base_type(@mime_type_name)
      fail ArgumentError, "Unknown mime type or suffix: #{mime_type_name}" if @mime_type.nil?
      super @mime_type_name
    end

    def self.parser_for(mime_type)
      mime_type = COMMON_ALIASES[mime_type] if COMMON_ALIASES.key? mime_type
      case mime_type
      when 'application/json'
        return JSON
      else
        fail NotImplementedError, "Parser support for #{mime_type} is not implemented"
      end
    end

    private

    def base_type(mime_type_name)
      media_type, _sub_type, _tree, suffix, _parameters = MIME_TYPE_FORMAT.match mime_type_name
      return MIME::Types["#{media_type}/#{suffix}"].first if media_type && suffix
      nil
    end
  end
end
