module SlackFormatter
  extend self

  def format(station)
    {
      text: "#{station.name}",
      attachments: [
        { text: "Available bikes: #{station.available_bikes}" },
        { text: "Free docks: #{station.free_docks}" }
      ]
    }.to_json
  end
end
