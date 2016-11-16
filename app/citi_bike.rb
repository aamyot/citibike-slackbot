require './app/controller/station'

class CitiBike
  def call(env)
    Station.new.call(env)
  end
end
