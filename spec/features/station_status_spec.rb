require './app/citi_bike'
require './spec/support/fake_citibike'
require 'webmock/rspec'
require 'json'

describe 'Bikes Availability' do
  before do
    stub_request(:any, /gbfs.citibikenyc.com/).to_rack(FakeCitiBike.new)
  end

  def app
    CitiBike.new
  end

  it 'returns the bike availability for the given station' do
    get('/bike')

    expect(last_response.status).to be(200)
    expect(last_response.content_type).to eq('application/json')
    expect(JSON.parse(last_response.body, symbolize_names: true)).to include(
      text: 'Howard St & Centre St',
      attachments: [
        { text: 'Available bikes: 21' },
        { text: 'Free docks: 5' }
      ]
    )
  end
end
