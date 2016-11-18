require_relative 'station'
require './app/support/json_feed'

class StationRepo
  attr_reader :stations_by_id

  def by_id(id)
    stations_by_id[id.to_s]
  end

  def all
    stations_by_id.values
  end

  def by_name(name)
    stations_by_id.values.find { |s| s.name.downcase.include?(name.downcase) }
  end

  def search(query)
    if is_an_integer?(query)
      station = by_id(query)
    else
      station = by_name(query)
    end
  end

  private

  def stations_by_id
    @stations_by_id ||=
      details[:data][:stations].inject({}) do |by_id, info|
        id = info[:station_id]
        status = statuses_by_station_id[id] || Hash.new(0)
        by_id.merge({ id => Station.new(info[:name], status[:num_bikes_available], status[:num_docks_available]) })
      end
  end

  def statuses_by_station_id
    @statuses_by_station_id ||=
      statuses.inject({}) { |by_id, status| by_id.merge({ status[:station_id] => status }) }
  end

  def details
    JsonFeed.for('https://gbfs.citibikenyc.com/gbfs/en/station_information.json')
  end

  def statuses
    JsonFeed.for('https://gbfs.citibikenyc.com/gbfs/en/station_status.json')[:data][:stations]
  end

  def is_an_integer?(text)
    text !~ /\D/
  end
end
