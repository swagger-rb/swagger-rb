require 'spec_helper'

module Swagger
  module V2
    describe APIDeclaration do
      let(:swagger_file) { 'spec/fixtures/petstore-full.yaml' }
      let(:swagger) { Swagger.load swagger_file }
      let(:expected_host) { 'petstore.swagger.wordnik.com' }
      let(:expected_basePath) { '/api' }

      context 'extras' do
        # These are utility methods, not part of the Swagger specification
        describe '#validate' do
          it 'returns true if the Swagger definition complies with the Swagger schema' do
            expect(swagger.validate).to eq(true)
          end

          it 'raises an exception if the Swagger definition does not comply with the Swagger schema' do
            swagger.swagger = 2.1
            expect { swagger.validate }.to raise_error(Swagger::InvalidDefinition)
          end
        end

        describe '#fully_validate' do
          it 'returns true if the Swagger definition complies with the Swagger schema' do
            expect(swagger.fully_validate).to eq(true)
          end

          it 'raises an exception if the Swagger definition does not comply with the Swagger schema' do
            swagger.swagger = 2.1
            expect { swagger.fully_validate }.to raise_error(Swagger::InvalidDefinition)
          end
        end

        describe '#uri_template', extension: true do
          it 'is combines the host and basePath into a single template' do
            # expect(swagger.uri_template).to eq(Addressable::Template.new("#{expected_host}#{expected_basePath}"))
            expect(swagger.uri_template).to eq("#{expected_host}#{expected_basePath}")
          end
        end
      end

      context 'Sample petstore API' do
        describe '#swagger' do
          subject { swagger.swagger }
          it { is_expected.to eq(2.0) }
        end

        describe '#info' do
          subject { swagger.info }
          it { is_expected.to be_a_kind_of Swagger::V2::Info }
          # See info_spec for more
        end

        describe '#host' do
          subject { swagger.host }
          pending { is_expected.to be_a_kind_of Addressable::Template }
          it { is_expected.to eq(expected_host) }
        end

        describe '#basePath' do
          subject { swagger.basePath }
          pending { is_expected.to be_a_kind_of Addressable::Template }
          it { is_expected.to eq(expected_basePath) }
        end

        describe '#schemes' do
          subject { swagger.schemes }
          it { is_expected.to eq(%w(http https ws wss)) }
        end

        describe '#consumes' do
          subject { swagger.consumes }
          it { is_expected.to eq(%w(application/json application/xml)) }
        end

        describe '#produces' do
          subject { swagger.produces }
          it { is_expected.to eq(%w(application/vnd.max+json application/xml)) }
        end

        skip '#paths'
        skip '#definitions'
        skip '#security'
      end
    end
  end
end
