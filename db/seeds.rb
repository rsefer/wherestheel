# https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme

jsonFilePath = 'lib/stations.json'

if File.exist?(jsonFilePath)
  Station.destroy_all
  jsonFile = File.read(jsonFilePath)
  stations = JSON.parse(jsonFile)
  stations.each do |station|
    latLng = station['Location'].gsub(/[()]/, '').split(/\s*,\s*/)
    s = Station.create(name: station['STATION_NAME'], map_id: station['MAP_ID'], stop_id: station['STOP_ID'], latitude: latLng[0], longitude: latLng[1])
    puts s
  end
end
