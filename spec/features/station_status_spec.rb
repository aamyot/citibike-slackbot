require './app/citi_bike'
require './spec/support/fake_citibike'
require 'json'

describe 'Bikes Availability' do
  before do
    stub_request(:any, /gbfs.citibikenyc.com/).to_rack(FakeCitiBike.new)
  end

  def app
    CitiBike.new
  end

  it 'returns the bike availability for the given station' do
    post '/stations', 'text' => '268'

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

  xit 'returns the bike availability for the given station' do
    post '/stations'

    expect(last_response.status).to be(200)
    expect(last_response.content_type).to eq('application/json')
    expect(JSON.parse(last_response.body, symbolize_names: true)).to include(
      text: 'Howard St & Centre St',
      attachments: [
        { text: 'Available bikes: 21' },
        { text: 'Free docks: 5' }
      ]
    ).and(include(
      text: 'W 52 St & 11 Ave',
      attachments: [
        { text: 'Available bikes: 19' },
        { text: 'Free docks: 20' }
      ]
    ))
  end
end
