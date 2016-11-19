class FakeCitiBike

  def initialize
    @app = Rack::Builder.new do
      map '/gbfs/en/station_status.json' do
        run StationStatus.new
      end

      map '/gbfs/en/station_information.json' do
        run StationInfo.new
      end
    end
  end

  def call(env)
    @app.call(env)
  end

  class StationStatus
    def call(env)
      [200, { 'Content-Type' => 'application/json' }, [station_status]]
    end

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
                  "num_bikes_disabled":0,
                  "num_docks_available":20,
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

  class StationInfo
    def call(env)
      [200, { 'Content-Type' => 'application/json' }, [station_info]]
    end

    def station_info
      %(
        {
         "last_updated":1479433433,
         "ttl":10,
         "data":{
            "stations":[
               {
                  "station_id":"72",
                  "name":"W 52 St & 11 Ave",
                  "short_name":"6926.01",
                  "lat":40.76727216,
                  "lon":-73.99392888,
                  "region_id":71,
                  "rental_methods":[
                     "KEY",
                     "CREDITCARD"
                  ],
                  "capacity":39,
                  "eightd_has_key_dispenser":false
               },
               {
                  "station_id":"268",
                  "name":"Howard St & Centre St",
                  "short_name":"5422.04",
                  "lat":40.71910537,
                  "lon":-73.99973337,
                  "region_id":71,
                  "rental_methods":[
                     "KEY",
                     "CREDITCARD"
                  ],
                  "capacity":27,
                  "eightd_has_key_dispenser":false
               },
               {
                 "station_id":"151",
                 "name":"Cleveland Pl & Spring St",
                 "short_name":"5492.05",
                 "lat":40.722103786686034,
                 "lon":-73.99724900722504,
                 "region_id":71,
                 "rental_methods":[
                    "KEY",
                    "CREDITCARD"
                 ],
                 "capacity":33,
                 "eightd_has_key_dispenser":false
               },
               {
                  "station_id":"42",
                  "name":"No Status",
                  "short_name":"5422.04",
                  "lat":42.71910537,
                  "lon":-42.99973337,
                  "region_id":71,
                  "rental_methods":[
                     "KEY",
                     "CREDITCARD"
                  ],
                  "capacity":27,
                  "eightd_has_key_dispenser":false
               }
             ]
           }
         }
      )
    end
  end
end
