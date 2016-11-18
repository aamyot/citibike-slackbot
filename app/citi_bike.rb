require './app/stations/station'
require './app/stations/station_repo'

class CitiBike
  attr_reader :station_repo

  def initialize
    @station_repo = StationRepo.new
  end

  def call(env)
    request = Rack::Request.new(env)
    query = request.params['text']
    station = station_repo.by_id(query)

    [200, { 'Content-Type' => 'application/json' }, respond_with(station)]
  end

  private

  def respond_with(station)
    [SlackFormatter.format(station)]
  end
end
