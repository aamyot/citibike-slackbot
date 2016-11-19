class GeoLocation
  attr_reader :lat_range, :long_range

  def initialize(lat, long, tolerance)
    @lat_range = Range.new(lat - tolerance, lat + tolerance)
    @long_range = Range.new(long - tolerance, long + tolerance)
  end

  def near(lat, long)
    lat_range.cover?(lat) && long_range.cover?(long)
  end
end
