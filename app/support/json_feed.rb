require 'json'
require 'net/http'

module JsonFeed
  extend self

  def for(uri)
    JSON.parse(Net::HTTP.get(URI(uri)), symbolize_names: true)
  end
end
