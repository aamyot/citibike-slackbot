require './app/slack/slack_formatter'
require 'json'

describe SlackFormatter do

  it 'converts a station into Slack format' do
    station = Station.new("Station Name", 22, 11)

    converted = SlackFormatter.format(station)

    expect(as_json(converted)).to include(
      response_type: 'ephemeral',
      attachments: [
        { title: 'Station Name', "text": "Avail. Bikes: 22\nFree Docks: 11" }
      ]
    )
  end

  it 'converts a list of stations into Slack format' do
    station1 = Station.new("Station1", 22, 11)
    station2 = Station.new("Station2", 9, 42)

    converted = SlackFormatter.format(station1, station2)

    expect(as_json(converted)).to include(
      response_type: 'ephemeral',
      attachments: [
        { title: 'Station1', "text": "Avail. Bikes: 22\nFree Docks: 11" },
        { title: 'Station2', "text": "Avail. Bikes: 9\nFree Docks: 42" }
      ]
    )
  end

  def as_json(text)
    JSON.parse(text, symbolize_names: true)
  end
end
