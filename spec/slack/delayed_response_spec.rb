require './app/slack/delayed_response'
require './spec/support/fake_slack'

describe DelayedResponse do
  let(:slack) { FakeSlack.new }

  before do
    stub_request(:any, /hooks.slack.com/).to_rack(slack)
  end

  it 'sends the station response back the slack' do
    station = Station.new("Station Name", 22, 11, 40, -73)
    response = SlackFormatter.format('http://hooks.slack.com', [station])

    DelayedResponse.post('http://hooks.slack.com', response)

    expect(slack.last_request).to have_attributes(body: response)
  end
end
