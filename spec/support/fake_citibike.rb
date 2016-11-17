class FakeCitiBike
  def call(env)
    [200, { 'Content-Type' => 'application/json' }, [station_status]]
  end

  private

  def station_status
    %(
      {
         "last_updated":1479392352,
         "ttl":10,
         "data":{
            "stations":[
               {
                "station_id":"72",
                "num_bikes_available":19,
                "num_bikes_disabled":1,
                "num_docks_available":19,
                "num_docks_disabled":0,
                "is_installed":1,
                "is_renting":1,
                "is_returning":1,
                "last_reported":1479392195,
                "eightd_has_available_keys":false
               },
               {
                "station_id":"268",
                "num_bikes_available":21,
                "num_bikes_disabled":1,
                "num_docks_available":5,
                "num_docks_disabled":0,
                "is_installed":1,
                "is_renting":1,
                "is_returning":1,
                "last_reported":1479392222,
                "eightd_has_available_keys":false
               },
               {
                "station_id":"82",
                "num_bikes_available":26,
                "num_bikes_disabled":0,
                "num_docks_available":1,
                "num_docks_disabled":0,
                "is_installed":1,
                "is_renting":1,
                "is_returning":1,
                "last_reported":1479392315,
                "eightd_has_available_keys":false
               }
            ]
         }
      }
    )
  end
end
