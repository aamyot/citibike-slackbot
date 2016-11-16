require 'json'

class CitiBike
  def call(env)
    ['200', {'Content-Type' => 'application/json'}, respond_with(station_info)]
  end

  private

  def respond_with(station_info)
    [station_info.to_json]
  end

  def station_info
    {
      text: 'Howard St & Centre St',
      attachments: [
        { text: 'Total: 27' },
        { text: 'Free docks: 0' },
        { text: 'Available bikes: 27' }
      ]
    }
  end
end
