# frozen_string_literal: true

require 'rack/utils'

RSpec.describe 'ServiceClient raise errors' do
  Rack::Utils::HTTP_STATUS_CODES.keys.select { |key| key >= 400 }.each do |status|
    %i[get delete get delete].each do |method|
      describe method.to_s.upcase do
        let(:headers) { { content_type: 'application/json' } }
        let(:body) { { request: { name: 'John Doe' } } }
        let(:url) { "https://mock-http-requests.onrender.com/#{status}" }

        it "returns #{status} status" do
          expect do
            if %i[get delete].include?(method)
              ServiceClient::Base.send(method, url)
            else
              ServiceClient::Base.send(method, url, headers: headers, body: body)
            end
          end.to raise_error(ServiceClient::Errors::ERRORS[status.to_s.to_sym])
        end
      end
    end
  end
end
