require 'spec_helper'

module Swagger
  module V2
    describe API do
      let(:swagger_file) { 'spec/fixtures/strava.json' }
      let(:swagger) { Swagger.load swagger_file }

      context 'Strava API' do
        describe '#swagger' do
          subject { swagger.swagger }
          it { is_expected.to eq('2.0') }
        end
      end
    end
  end
end
