require 'spec_helper'

module Swagger
  module V2
    describe Info do
      context 'Sample petstore API' do
        let(:swagger_file) { 'spec/fixtures/petstore-full.yaml' }
        let(:swagger) { Swagger.load swagger_file }
        subject { swagger.info }

        describe '#version' do
          subject { swagger.info.version }
          it { is_expected.to eq('1.0.0') }
        end

        describe '#title' do
          subject { swagger.info.title }
          it { is_expected.to eq('Swagger Petstore') }
        end

        describe '#description' do
          subject { swagger.info.description }
          let(:expected) do
            [
              'A sample API that uses a petstore as an example to demonstrate',
              "features in the swagger-2.0 specification\n"
            ].join("\n")
          end
          it { is_expected.to eq(expected) }
        end

        describe '#termsOfService' do
          subject { swagger.info.termsOfService }
          it { is_expected.to eq('http://helloreverb.com/terms/') }
          pending "Spec isn't clear if this should be URL, plaintext, or Markdown"
        end

        describe '#contact' do
          subject { swagger.info.contact }

          describe '#name' do
            subject { swagger.info.contact.name }
            it { is_expected.to eq('Wordnik API Team') }
          end

          describe '#url' do
            subject { swagger.info.contact.url }
            pending { is_expected.to be_a_kind_of(Addressable::URI) }
            it { is_expected.to eq('http://madskristensen.net') }
          end

          describe '#email' do
            subject { swagger.info.contact.email }
            pending 'Is there a more appropriate class for email?'
            it { is_expected.to eq('foo@example.com') }
          end
        end

        describe '#license' do
          subject { swagger.info.license }

          describe '#name' do
            subject { swagger.info.license.name }
            it { is_expected.to eq('MIT') }
          end

          describe '#url' do
            subject { swagger.info.license.url }
            pending { is_expected.to be_a_kind_of(Addressable::URI) }
            it { is_expected.to eq('http://choosealicense.com/licenses/mit/') }
          end
        end
      end
    end
  end
end
