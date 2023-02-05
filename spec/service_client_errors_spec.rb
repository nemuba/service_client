# frozen_string_literal: true

RSpec.describe 'ServiceClient errors' do
  ServiceClient::Errors::ERRORS.each do |code, error|
    it "raise error with status code #{code}" do
      expect { ServiceClient::Call.get("https://mock.codes/#{code}") }.to raise_error(error)
    end
  end
end
