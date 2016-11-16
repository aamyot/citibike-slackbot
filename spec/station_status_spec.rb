require './app/citi_bike'
require 'json'

describe 'Bikes Availability' do
  def app
    CitiBike.new
  end

  it 'returns the bike availability for the given station' do
    get('/bike')

    expect(last_response.status).to be(200)
    expect(last_response.content_type).to eq('application/json')
    # expect(JSON.parse(last_response.body, symbolize_names: true)).to include(
    #   text: 'Howard St & Centre St',
    #   attachments: [
    #     { text: 'Available bikes: 27' },
    #     { text: 'Free docks: 0' }
    #   ]
    # )
  end
end
