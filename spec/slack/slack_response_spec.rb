require './app/slack/slack_formatter'
require 'json'

describe SlackFormatter do

  it 'converts a station into Slack format' do
    station = Station.new("Station Name", 22, 11)

    converted = SlackFormatter.format(station)

    expect(as_json(converted)).to include(
      text: 'Station Name',
      attachments: [
        { text: 'Available bikes: 22' },
        { text: 'Free docks: 11' }
      ]
    )
  end

  def as_json(text)
    JSON.parse(text, symbolize_names: true)
  end
end
