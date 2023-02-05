RSpec.describe ServiceClient do
  it 'has a version number' do
    expect(ServiceClient::VERSION).not_to be nil
  end

  context 'Call' do
    let(:call) { ServiceClient::Call.get('https://mock.codes/200') }

    it 'have an method with response class instance' do
      expect(call).to be_a(ServiceClient::Response)
    end

    it 'response have an method data' do
      expect(call).to respond_to(:data)
    end

    it 'response have an method headers' do
      expect(call).to respond_to(:headers)
    end

    it 'response have an method code' do
      expect(call).to respond_to(:code)
    end

    it 'raise error when missing params' do
      expect { ServiceClient::Call.get(nil) }.to raise_error(ServiceClient::ParamsRequired)
      expect { ServiceClient::Call.post(nil, body: nil) }.to raise_error(ServiceClient::ParamsRequired)
      expect { ServiceClient::Call.put(nil, body: nil) }.to raise_error(ServiceClient::ParamsRequired)
      expect { ServiceClient::Call.delete(nil) }.to raise_error(ServiceClient::ParamsRequired)
    end
  end
end
