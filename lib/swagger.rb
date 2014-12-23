require 'swagger/version'
require 'swagger/boolean'
require 'addressable/uri'
require 'addressable/template'
require 'hashie'

# Provides loading and building capabilities for Swagger.
# @see http://swagger.io Swagger
module Swagger
  RESOURCES_DIR = File.expand_path '../../resources/', __FILE__
  class InvalidDefinition < StandardError
    def initialize(errors)
      @errors = errors
      super("The Swagger definition is invalid. The following errors were detected: #{errors.inspect}")
    end
  end
  # Instantiates a Swagger::API from the content.
  # @param [Hash] opts the build options
  # @option opts [String] :version the target Swagger specification version
  # @returns [API]
  def self.build(content, opts = {})
    parser ||= Swagger::Parsers.parser_for(opts[:format])
    content = parser.parse(content) unless parser.nil?
    Swagger::API.build_api(content)
  end

  # Load a Swagger document from a file.
  # @param [Hash] opts the load options
  # @option opts [String] :format the format (yaml or json). Detected by file extension if omitted.
  # @returns [API] a Swagger API object
  def self.load(file, opts = {})
    ext = File.extname file
    opts[:format] = ext
    content = File.read(file)
    build(content, opts)
  end

  # Creates a Swagger::Builder that can be used to create a Swagger document.
  # @param [Hash] opts the build options
  # @option opts [String] :version the target Swagger specification version
  # @returns Swagger::Builder
  def self.builder(opts = {})
    Swagger::Builder.builder(opts)
  end
end

require 'swagger/attachable'
require 'swagger/swagger_object'
require 'swagger/schema'
require 'swagger/uri'
require 'swagger/uri_template'
require 'swagger/parsers'
require 'swagger/mime_type'
require 'swagger/api'
require 'swagger/builder'
