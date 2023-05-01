# frozen_string_literal: true

RSpec.describe ServiceClient do
  it 'has a version number' do
    expect(ServiceClient::VERSION).not_to be nil
  end

  context 'Base' do
    describe 'GET' do
      let(:base) { ServiceClient::Base.get('https://mock-http-requests.onrender.com/200') }

      it 'have an method with response class instance' do
        expect(base).to be_a(ServiceClient::Response)
      end

      it 'response have an method data' do
        expect(base).to respond_to(:data)
      end

      it 'response have an method headers' do
        expect(base).to respond_to(:headers)
      end

      it 'response have an method code' do
        expect(base).to respond_to(:code)
      end

      it 'raise error when missing params' do
        expect { ServiceClient::Base.get(nil) }.to raise_error(ServiceClient::ParamsRequired)
      end
    end

    describe 'POST' do
      let(:body) { { request: { test: 'test' } } }
      let(:headers) { { content_type: 'application/json' } }
      let(:base) { ServiceClient::Base.post('https://mock-http-requests.onrender.com/200', headers: headers, body: body) }

      it 'have an method with response class instance' do
        expect(base).to be_a(ServiceClient::Response)
      end

      it 'response have an method data' do
        expect(base).to respond_to(:data)
      end

      it 'response have an method headers' do
        expect(base).to respond_to(:headers)
      end

      it 'response have an method code' do
        expect(base).to respond_to(:code)
      end

      it 'raise error when missing params' do
        expect { ServiceClient::Base.post(nil, body: nil) }.to raise_error(ServiceClient::ParamsRequired)
      end
    end

    describe 'PUT' do
      let(:body) { { request: { test: 'test' } } }
      let(:headers) { { content_type: 'application/json' } }
      let(:base) { ServiceClient::Base.put('https://mock-http-requests.onrender.com/200', headers: headers, body: body) }

      it 'have an method with response class instance' do
        expect(base).to be_a(ServiceClient::Response)
      end

      it 'response have an method data' do
        expect(base).to respond_to(:data)
      end

      it 'response have an method headers' do
        expect(base).to respond_to(:headers)
      end

      it 'response have an method code' do
        expect(base).to respond_to(:code)
      end

      it 'raise error when missing params' do
        expect { ServiceClient::Base.put(nil, body: nil) }.to raise_error(ServiceClient::ParamsRequired)
      end
    end

    describe 'DELETE' do
      let(:base) { ServiceClient::Base.delete('https://mock-http-requests.onrender.com/200') }

      it 'have an method with response class instance' do
        expect(base).to be_a(ServiceClient::Response)
      end

      it 'response have an method data' do
        expect(base).to respond_to(:data)
      end

      it 'response have an method headers' do
        expect(base).to respond_to(:headers)
      end

      it 'response have an method code' do
        expect(base).to respond_to(:code)
      end

      it 'raise error when missing params' do
        expect { ServiceClient::Base.delete(nil) }.to raise_error(ServiceClient::ParamsRequired)
      end
    end
  end
end
