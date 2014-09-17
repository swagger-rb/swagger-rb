require 'thor'
require 'swagger'
require 'swagger/thor/version'
require 'swagger/thor/cli'

module Swagger
  module Thor
    TEMPLATE_DIR = File.expand_path 'templates/', Swagger::RESOURCES_DIR
  end
end
