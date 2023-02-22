# frozen_string_literal: true

require 'rack/utils'

RSpec.describe 'ServiceClient raise errors' do
  let(:headers) { { content_type:  'application/json' } }
  let(:body) { { request: { name: 'John Doe' } } }

  describe 'GET' do
    (400..511).to_a.each do |status|
      next unless Rack::Utils::HTTP_STATUS_CODES.key?(status)

      it "returns #{status} status" do
        expect { 
          ServiceClient::Base.get("https://mock-http-requests.onrender.com/#{status}")
        }.to raise_error(ServiceClient::Errors::ERRORS[status.to_s.to_sym])
      end
    end
  end

  describe 'POST' do
    (400..511).to_a.each do |status|
      next unless Rack::Utils::HTTP_STATUS_CODES.key?(status)

      it "returns #{status} status" do
        expect {
          ServiceClient::Base.post("https://mock-http-requests.onrender.com/#{status}", headers: headers, body: body)
        }.to raise_error(ServiceClient::Errors::ERRORS[status.to_s.to_sym])
      end
    end
  end

  describe 'PUT' do
    (400..511).to_a.each do |status|
      next unless Rack::Utils::HTTP_STATUS_CODES.key?(status)

      it "returns #{status} status" do
        expect { 
          ServiceClient::Base.put("https://mock-http-requests.onrender.com/#{status}", headers: headers, body: body)
        }.to raise_error(ServiceClient::Errors::ERRORS[status.to_s.to_sym])
      end
    end
  end

  describe 'DELETE' do
    (400..511).to_a.each do |status|
      next unless Rack::Utils::HTTP_STATUS_CODES.key?(status)

      it "returns #{status} status" do
        expect { 
          ServiceClient::Base.delete("https://mock-http-requests.onrender.com/#{status}")
        }.to raise_error(ServiceClient::Errors::ERRORS[status.to_s.to_sym])
      end
    end
  end
end
