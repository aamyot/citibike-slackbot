require 'json'

module SlackFormatter
  extend self

  def format(response_url, stations)
    {
      response_type: 'in_channel',
      attachments:
        stations.flatten.map do |station|
          {
            title: "#{station.name} (#{station.lat},#{station.long})",
            text: "Avail. Bikes: #{station.available_bikes}\nFree Docks: #{station.free_docks}"
          }
        end
    }.to_json
  end
end
