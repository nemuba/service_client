# frozen_string_literal: true

RSpec.describe 'ServiceClient request options' do
  let(:response) do
    instance_double(
      HTTParty::Response,
      code: 200,
      parsed_response: { 'ok' => true },
      headers: {}
    )
  end

  let(:client) do
    Class.new(ServiceClient::Base).tap do |klass|
      klass.base_url 'https://api.example.com'
      klass.default_headers 'Accept' => 'application/json', 'X-Default' => 'default'
      klass.default_options timeout: 5, follow_redirects: true
    end
  end

  before do
    allow(HTTParty).to receive(:send).and_return(response)
  end

  it 'combines default and per-request options with explicit arguments taking precedence' do
    client.get(
      'customers',
      headers: { 'X-Default' => 'request' },
      query: { page: 2 },
      timeout: 15,
      options: { timeout: 10, follow_redirects: false }
    )

    expect(HTTParty).to have_received(:send).with(
      :get,
      'https://api.example.com/customers',
      {
        timeout: 15,
        follow_redirects: false,
        headers: { 'Accept' => 'application/json', 'X-Default' => 'request' },
        query: { page: 2 }
      }
    )
  end

  it 'merges headers from defaults, generic options, and explicit headers' do
    client.get(
      'customers',
      headers: { 'Authorization' => 'Bearer token' },
      options: { headers: { 'X-Default' => 'option' } }
    )

    expect(HTTParty).to have_received(:send).with(
      :get,
      'https://api.example.com/customers',
      hash_including(
        headers: {
          'Accept' => 'application/json',
          'X-Default' => 'option',
          'Authorization' => 'Bearer token'
        }
      )
    )
  end

  it 'does not mutate default or per-request option hashes' do
    defaults = { timeout: 5, headers: { 'X-Default-Option' => 'default' } }
    request_options = { timeout: 10, headers: { 'X-Request-Option' => 'request' } }
    client.default_options(defaults)

    client.get('customers', timeout: 15, options: request_options)

    expect(defaults).to eq(timeout: 5, headers: { 'X-Default-Option' => 'default' })
    expect(request_options).to eq(timeout: 10, headers: { 'X-Request-Option' => 'request' })
  end

  it 'omits unset optional values while preserving false values' do
    client.default_options(nil)
    client.default_headers(nil)

    client.get('customers', options: { follow_redirects: false })

    expect(HTTParty).to have_received(:send).with(
      :get,
      'https://api.example.com/customers',
      { follow_redirects: false }
    )
  end

  %i[post put delete].each do |method|
    it "passes body and query parameters through #{method.to_s.upcase}" do
      client.public_send(method, 'customers', body: { name: 'Ada' }, query: { notify: true })

      expect(HTTParty).to have_received(:send).with(
        method,
        'https://api.example.com/customers',
        hash_including(body: { name: 'Ada' }, query: { notify: true })
      )
    end
  end

  it 'still raises ParamsRequired before making a request when the URL is nil' do
    expect { client.get(nil, query: { page: 1 }) }.to raise_error(ServiceClient::ParamsRequired)
    expect(HTTParty).not_to have_received(:send)
  end
end
