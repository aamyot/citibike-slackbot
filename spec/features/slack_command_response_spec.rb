require './app/citi_bike'
require './spec/support/fake_citibike'
require './spec/support/fake_slack'
require 'json'

describe 'Slack Command Response' do
  let(:app) { CitiBike.new }
  let(:citi_bike) { FakeCitiBike.new }
  let(:slack) { FakeSlack.new }

  before do
    stub_request(:any, /gbfs.citibikenyc.com/).to_rack(citi_bike)
    stub_request(:any, /hooks.slack.com/).to_rack(slack)
  end

  it 'returns the bike availability for the given station id' do
    post '/slack', 'text' => '268', 'response_url' => 'http://response.url'

    expect(last_response.status).to be(200)
    expect(last_response.content_type).to eq('application/json')
    expect(last_response.body).to include(station_with('Howard St & Centre St', 21, 5, 40.71910537, -73.99973337))
  end

  it 'returns the bike availability for the station matching the given name' do
    post '/slack', 'text' => 'howard'

    expect(last_response.body).to include('Howard St & Centre St')
  end

  it 'returns all stations matching the given name' do
    post '/slack', 'text' => 'St'

    expect(last_response.body).to include('W 52 St & 11 Ave').and(include('Howard St & Centre St'))
  end

  it 'returns all stations near a given station' do
    post '/slack', 'text' => '40.720,-74.000'

    expect(last_response.body).to include('Cleveland Pl & Spring St').and(include('Howard St & Centre St'))
  end

  it 'returns an error message when no station matches the query' do
    post '/slack', 'text' => 'unknown station'

    expect(last_response.body).to eq('Could not find any station matching your query. Try `/bike help` for possible options')
  end

  it 'returns with a delayed response when requested' do
    post '/slack', { 'text' => '40.720,-74.000', 'response_url' => 'http://hooks.slack.com', 'delayed' => 'true' }

    expect(last_response.status).to be(200)
    expect(last_response.body).to be_empty
    expect(slack.last_request).to have_attributes(
      body: include('Cleveland Pl & Spring St').and(include('Howard St & Centre St'))
    )
  end

  def station_with(name, available_bikes, free_docks, lat, long)
   SlackFormatter.format('http://response.url', [Station.new(name, available_bikes, free_docks, lat, long)])
  end
end
