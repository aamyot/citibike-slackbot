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
    response_url = request.params['response_url']
    stations = station_repo.search(query)

    if delay_response? request
      DelayedResponse.post(response_url, SlackFormatter.format(response_url, stations))
      [200, {}, []]
    else
      [200, { 'Content-Type' => 'application/json' }, [respond_with(response_url, stations)]]
    end
  end

  private

  def delay_response?(request)
    request['delayed'] == 'true'
  end

  def respond_with(response_url, stations)
    return no_match unless stations.any?

    SlackFormatter.format(response_url, stations)
  end

  def no_match
    'Could not find any station matching your query. Try `/bike help` for possible options'
  end
end
