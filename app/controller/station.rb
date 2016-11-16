require 'json'
require 'net/http'

class Station
  def call(env)
    [200, { 'Content-Type' => 'application/json' }, respond_with(station_info)]
  end

  private

  def respond_with(station_info)
    [station_info.to_json]
  end

  def station_info
    stations = JSON.parse(Net::HTTP.get(URI('https://gbfs.citibikenyc.com/gbfs/en/station_status.json')), symbolize_names: true)
    station = stations[:data][:stations].find{ |s| s[:station_id] == "268" }
    {
      text: 'Howard St & Centre St',
      attachments: [
        { text: "Available bikes: #{station[:num_bikes_available]}" },
        { text: "Free docks: #{station[:num_docks_available]}" }
      ]
    }
  end
end
