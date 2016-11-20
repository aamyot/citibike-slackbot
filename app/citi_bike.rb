require './app/stations/station_repo'
require './app/slack/slack_formatter'

class CitiBike
  attr_reader :station_repo

  def initialize
    @station_repo = StationRepo.new
  end

  def call(env)
    request = Rack::Request.new(env)
    query = request.params['text']

    stations = station_repo.search(query)

    [200, { 'Content-Type' => 'application/json' }, [respond_with(stations)]]
  end

  private

  def respond_with(stations)
    return no_match unless stations.any?

    SlackFormatter.format(*stations)
  end

  def no_match
    ['Could not find any station matching your query. Try `/bike help` for possible options']
  end
end
