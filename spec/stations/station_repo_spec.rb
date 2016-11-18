require './app/stations/station_repo'
require './spec/support/fake_citibike'

describe StationRepo do
  subject { StationRepo.new }

  before do
    stub_request(:any, /gbfs.citibikenyc.com/).to_rack(FakeCitiBike.new)
  end

  it 'returns the list of all stations' do
    stations = subject.all

    expect(stations).to include(
      have_attributes(name: 'W 52 St & 11 Ave', available_bikes: 19, free_docks: 20),
      have_attributes(name: 'Howard St & Centre St', available_bikes: 21, free_docks: 5)
    )
  end

  it 'returns a station for a given id' do
    station = subject.by_id(72)

    expect(station).to have_attributes(
      name: 'W 52 St & 11 Ave',
      available_bikes: 19,
      free_docks: 20
    )
  end

  it 'returns no availibility for station without a status' do
    station = subject.by_id(42)

    expect(station).to have_attributes(
      name: 'No Status',
      available_bikes: 0,
      free_docks: 0
    )
  end

  it 'finds all stations matching the given name' do
    stations = subject.by_name('St')

    expect(stations).to include(
      have_attributes(name: 'Howard St & Centre St'),
      have_attributes(name: 'W 52 St & 11 Ave'),
    )
  end
end
