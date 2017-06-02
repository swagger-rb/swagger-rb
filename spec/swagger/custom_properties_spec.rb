require 'spec_helper'

module Swagger
  module V2
    describe API do
      let(:swagger_file) { 'spec/fixtures/custom-properties.yaml' }
      let(:swagger) { Swagger.load swagger_file }

      context 'custom properties' do
        describe 'getting a custom property' do
          it 'should allow me to get a custom x- prefixed property' do
            operation = swagger.paths['/pets'].get

            expect(operation['x-my-custom-param']).to eq('whatever the hell I want!')
          end
        end
      end

    end

  end
end
