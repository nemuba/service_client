# frozen_string_literal: true

RSpec.describe ServiceClient do
  it 'has a version number' do
    expect(ServiceClient::VERSION).not_to be nil
  end

  context 'Base' do
    shared_examples 'a method with response class instance' do |http_method|
      let(:base) { http_method.call('https://mock-http-requests.onrender.com/200') }

      it 'returns a ServiceClient::Response instance' do
        expect(base).to be_a(ServiceClient::Response)
      end

      it 'response has a data method' do
        expect(base).to respond_to(:data)
      end

      it 'response has a headers method' do
        expect(base).to respond_to(:headers)
      end

      it 'response has a code method' do
        expect(base).to respond_to(:code)
      end

      it 'raises an error when missing params' do
        expect { http_method.call(nil) }.to raise_error(ServiceClient::ParamsRequired)
      end
    end

    context 'GET' do
      include_examples 'a method with response class instance', ServiceClient::Base.method(:get)
    end

    context 'POST' do
      let(:body) { { request: { test: 'test' } } }
      let(:headers) { { content_type: 'application/json' } }
      let(:base) { ServiceClient::Base.post('https://mock-http-requests.onrender.com/200', headers: headers, body: body) }

      include_examples 'a method with response class instance', ServiceClient::Base.method(:post)
    end

    context 'PUT' do
      let(:body) { { request: { test: 'test' } } }
      let(:headers) { { content_type: 'application/json' } }
      let(:base) { ServiceClient::Base.put('https://mock-http-requests.onrender.com/200', headers: headers, body: body) }

      include_examples 'a method with response class instance', ServiceClient::Base.method(:put)
    end

    context 'DELETE' do
      include_examples 'a method with response class instance', ServiceClient::Base.method(:delete)
    end
  end
end
