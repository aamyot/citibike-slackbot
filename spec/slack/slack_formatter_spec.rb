require './app/slack/slack_formatter'
require 'json'

describe SlackFormatter do

  it 'converts a station into Slack format' do
    station = Station.new("Station Name", 22, 11, 40.7, -74.0)

    converted = SlackFormatter.format('http://response.url', [station])

    expect(as_json(converted)).to include(
      response_type: 'in_channel',
      attachments: [
        { title: 'Station Name (40.7,-74.0)', text: "Avail. Bikes: 22\nFree Docks: 11" }
      ]
    )
  end

  it 'converts a list of stations into Slack format' do
    station1 = Station.new("Station1", 22, 11)
    station2 = Station.new("Station2", 9, 42)

    converted = SlackFormatter.format('http://response.url', [station1, station2])

    expect(converted).to include('Station1').and(include('Station2'))
  end

  def as_json(text)
    JSON.parse(text, symbolize_names: true)
  end
end
