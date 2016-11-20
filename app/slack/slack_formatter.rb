require 'json'

module SlackFormatter
  extend self

  def format(*stations)
    {
      response_type: 'ephemeral',
      attachments:
        stations.flatten.map do |station|
          {
            title: "#{station.name}",
            text: "Avail. Bikes: #{station.available_bikes}\nFree Docks: #{station.free_docks}",
            actions: [
              {
                "name": "near",
                "text": "Near",
                "type": "button",
                "value": "#{station.lat},#{station.long}"
              }
            ]
          }
        end
    }.to_json
  end
end
