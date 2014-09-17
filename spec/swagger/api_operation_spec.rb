require 'spec_helper'

module Swagger
  module V2
    describe APIOperation do
      context 'Sample petstore API' do
        let(:swagger_file) { 'spec/fixtures/petstore-full.yaml' }
        let(:swagger) { Swagger.load swagger_file }
        subject { swagger.paths['/pets'].get }

        context 'calculated fields' do # not defined directly in the swagger spec
          describe '#parent' do
            subject { swagger.paths['/pets'].get.parent }
            it { is_expected.to eq(swagger.paths['/pets']) }
          end

          describe '#uri_template' do
            it 'is calculated from the host, basePath, and path' do
              expect(subject.uri_template).to eq('petstore.swagger.wordnik.com/api/pets')
            end
          end
        end

        describe '#tags' do
          subject { swagger.paths['/pets'].get.tags }
          it { is_expected.to eq(%w(Things That Do Stuff)) }
        end

        describe '#summary' do
          subject { swagger.paths['/pets'].get.summary }
          it { is_expected.to eq('Gets pets') }
        end

        # rubocop:disable Metrics/LineLength
        describe '#description' do
          subject { swagger.paths['/pets'].get.description }
          it do
            expected = <<-'EOS'.gsub(/^[ \t]+/, '').strip
            Returns all pets from the system that the user has access to
            Nam sed condimentum est. Maecenas tempor sagittis sapien, nec rhoncus sem sagittis sit amet. Aenean at gravida augue, ac iaculis sem. Curabitur odio lorem, ornare eget elementum nec, cursus id lectus. Duis mi turpis, pulvinar ac eros ac, tincidunt varius justo. In hac habitasse platea dictumst. Integer at adipiscing ante, a sagittis ligula. Aenean pharetra tempor ante molestie imperdiet. Vivamus id aliquam diam. Cras quis velit non tortor eleifend sagittis. Praesent at enim pharetra urna volutpat venenatis eget eget mauris. In eleifend fermentum facilisis. Praesent enim enim, gravida ac sodales sed, placerat id erat. Suspendisse lacus dolor, consectetur non augue vel, vehicula interdum libero. Morbi euismod sagittis libero sed lacinia.

            Sed tempus felis lobortis leo pulvinar rutrum. Nam mattis velit nisl, eu condimentum ligula luctus nec. Phasellus semper velit eget aliquet faucibus. In a mattis elit. Phasellus vel urna viverra, condimentum lorem id, rhoncus nibh. Ut pellentesque posuere elementum. Sed a varius odio. Morbi rhoncus ligula libero, vel eleifend nunc tristique vitae. Fusce et sem dui. Aenean nec scelerisque tortor. Fusce malesuada accumsan magna vel tempus. Quisque mollis felis eu dolor tristique, sit amet auctor felis gravida. Sed libero lorem, molestie sed nisl in, accumsan tempor nisi. Fusce sollicitudin massa ut lacinia mattis. Sed vel eleifend lorem. Pellentesque vitae felis pretium, pulvinar elit eu, euismod sapien.
            EOS
            is_expected.to eq(expected)
          end
        end
        # rubocop:enable Metrics/LineLength

        describe '#operationId' do
          subject { swagger.paths['/pets'].get.operationId }
          it { is_expected.to eq('Get Pets') }
        end

        # TODO: Implement alias #operation_id

        describe '#produces' do
          subject { swagger.paths['/pets'].get.produces }
          it { is_expected.to eq(%w(application/json)) }
        end

        skip '#consumes' # swagger spec update needed
        describe '#parameters' do
          subject { swagger.paths['/pets'].get.parameters }
          it { is_expected.to be_an(Array) }
          it 'contains Parameter objects' do
            expect(subject.size).to eq(2)
            subject.each do |parameter|
              expect(parameter).to be_a_kind_of(Parameter)
            end
          end
        end
        skip '#resources' # complex type

        describe '#schemes' do
          subject { swagger.paths['/pets'].get.schemes }
          it { is_expected.to eq(%w(http https)) }
        end

        describe '#default_response' do
          subject { swagger.paths['/pets'].get.default_response }
          it 'is selects the response labeled default' do
            expect(subject.description).to eq('pet response (default)')
          end
        end
      end
    end
  end
end
