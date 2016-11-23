class DelayedResponse
  def self.post(url, message)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = message
      http.request(request)
    end
  end
end
