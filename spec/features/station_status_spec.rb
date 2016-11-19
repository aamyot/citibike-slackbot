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

  it 'returns the bike availability for the given station id' do
    post '/stations', 'text' => '268'

    expect(last_response.status).to be(200)
    expect(last_response.content_type).to eq('application/json')
    expect(last_response.body).to include('Howard St & Centre St')
  end

  it 'returns the bike availability for the station matching the given name' do
    post '/stations', 'text' => 'howard'

    expect(last_response.body).to include(station_with('Howard St & Centre St', 21, 5))
  end

  it 'returns all stations matching the given name' do
    post '/stations', 'text' => 'St'

    expect(last_response.body).to include('W 52 St & 11 Ave').and(include('Howard St & Centre St'))
  end

  it 'returns all stations near a given station' do
    post '/stations', 'text' => '40.720, -74.000'

    expect(last_response.body).to include('Cleveland Pl & Spring St').and(include('Howard St & Centre St'))
  end

  def station_with(name, available_bikes, free_docks)
   SlackFormatter.format(Station.new(name, available_bikes, free_docks))
  end
end
