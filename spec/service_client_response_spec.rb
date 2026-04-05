# frozen_string_literal: true

RSpec.describe ServiceClient::Response do
  let(:mock_response) do
    instance_double(
      'HTTParty::Response',
      code: http_code,
      parsed_response: {},
      headers: {}
    )
  end

  subject(:response) { described_class.new(mock_response) }

  describe '#status' do
    context 'when HTTP code is 200' do
      let(:http_code) { 200 }

      it 'returns "OK"' do
        expect(response.status).to eq('OK')
      end
    end

    context 'when HTTP code is 201' do
      let(:http_code) { 201 }

      it 'returns "Created"' do
        expect(response.status).to eq('Created')
      end
    end

    context 'when HTTP code is 404' do
      let(:http_code) { 404 }

      it 'returns "Not Found"' do
        expect(response.status).to eq('Not Found')
      end
    end

    context 'when HTTP code is 500' do
      let(:http_code) { 500 }

      it 'returns "Internal Server Error"' do
        expect(response.status).to eq('Internal Server Error')
      end
    end

    context 'when HTTP code is unknown (e.g. 999)' do
      let(:http_code) { 999 }

      it 'returns "Unknown Status 999"' do
        expect(response.status).to eq('Unknown Status 999')
      end
    end
  end

  describe '#code' do
    let(:http_code) { 200 }

    it 'returns the integer HTTP code' do
      expect(response.code).to eq(200)
    end
  end
end
