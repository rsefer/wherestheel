class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_station_from_json(station_id)
    file = File.read('lib/stations.json')
    stations = JSON.parse(file)
    tempTitle = stations.select do |hash|
      hash['MAP_ID'] == station_id.to_i
    end
    if tempTitle.present?
      @stationTitle = tempTitle.first['STATION_NAME']
    else
      @stationTitle = ''
    end
  end

end
