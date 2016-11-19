require './app/stations/geo_location'

describe GeoLocation do
  it 'returns if a point is within the boundaries of a given point' do
    geo_location = GeoLocation.new(40.010, -80.020, 0.005)

    expect(geo_location.near(40.015, -80.020)).to be(true)
    expect(geo_location.near(40.005, -80.020)).to be(true)
    expect(geo_location.near(40.010, -80.024)).to be(true)
    expect(geo_location.near(40.010, -80.015)).to be(true)
    expect(geo_location.near(40.012, -80.017)).to be(true)

    expect(geo_location.near(40.020, -80.045)).to be(false)
    expect(geo_location.near(40.010, -81.00)).to be(false)
  end

end
