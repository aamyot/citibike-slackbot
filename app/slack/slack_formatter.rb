require 'json'

module SlackFormatter
  extend self

  def format(*stations)
    {
      attachments:
        stations.flatten.map do |station|
          {
            title: "#{station.name}",
            text: "Avail. Bikes: #{station.available_bikes}\nFree Docks: #{station.free_docks}"
          }
        end
    }.to_json
  end
end
