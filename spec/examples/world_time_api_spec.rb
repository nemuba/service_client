# frozen_string_literal: true

require './examples/world_time_api'

RSpec.describe WorldTimeApi do
  it '#timezones' do
    expect(WorldTimeApi.timezones).to be_a(Array)
  end

  it '#get_timezone' do
    timezone = WorldTimeApi.get_timezone('Europe/Moscow')

    expect(timezone).to be_a(Hash)
    expect(timezone['timezone']).to eq('Europe/Moscow')
    expect(timezone['abbreviation']).to eq('MSK')
  end

  it '#client_ip' do
    timezone = WorldTimeApi.client_ip

    expect(timezone).to be_a(Hash)
    expect(timezone).to have_key('timezone')
    expect(timezone).to have_key('datetime')
  end

  it '#client_ip with ip 8.8.8.8' do
    timezone = WorldTimeApi.client_ip('8.8.8.8')

    expect(timezone).to be_a(Hash)
    expect(timezone).to have_key('timezone')
    expect(timezone).to have_key('datetime')
  end
end
