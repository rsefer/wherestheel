# https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme

jsonFilePath = 'lib/stations.json'

if File.exist?(jsonFilePath)
  Station.destroy_all
  jsonFile = File.read(jsonFilePath)
  stations = JSON.parse(jsonFile)
  stations.each do |station|
    latLng = station['Location'].gsub(/[()]/, '').split(/\s*,\s*/)
    colorCount = 0
    color = 'multiple'
    if station['RED'] == 'true'
      color = 'Red'
      colorCount += 1
    end
    if station['BLUE'] == 'true'
      color = 'Blue'
      colorCount += 1
    end
    if station['G'] == 'true'
      color = 'G'
      colorCount += 1
    end
    if station['BRN'] == 'true'
      color = 'Brn'
      colorCount += 1
    end
    if station['P'] == 'true'
      color = 'P'
      colorCount += 1
    end
    # Skipping Pexp
    if station['Y'] == 'true'
      color = 'Y'
      colorCount += 1
    end
    if station['Pnk'] == 'true'
      color = 'Pnk'
      colorCount += 1
    end
    if station['O'] == 'true'
      color = 'O'
      colorCount += 1
    end
    if colorCount != 1
      color = 'multiple'
    end
    s = Station.create(name: station['STATION_NAME'], map_id: station['MAP_ID'], stop_id: station['STOP_ID'], color: color, latitude: latLng[0], longitude: latLng[1])
    puts s
  end
end
