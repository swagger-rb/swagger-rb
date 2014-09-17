require 'swagger/thor/generate'
require 'swagger/thor/convert'

module Swagger
  module Thor
    class CLI < ::Thor
      namespace :swagger
      register(Swagger::Thor::Generate, 'generate', 'generate', 'Generate a project from Swagger')
      register(Swagger::Thor::Convert, 'convert', 'convert', 'Convert from Swagger 1.2 to 2.0')
    end
  end
end
