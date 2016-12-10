class PagesController < ApplicationController
  before_action :get_station_arrivals, only: [:station, :update_station_arrivals]

  def index
  end

  def station
  end

  def update_station_arrivals
    @dir1Arrivals = @dir1Arrivals
    @dir5Arrivals = @dir5Arrivals
    respond_to do |format|
      format.js
    end
  end

  private
    def get_station_arrivals
      max = 10
      request = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=#{ENV["cta_train_api_key"]}&outputType=JSON&max=#{max}&mapid=#{params[:id]}"
      response = HTTParty.get request
      json = ActiveSupport::JSON
      arrivals = json.decode(response.body)['ctatt']['eta']
      @dir1Arrivals = []
      @dir5Arrivals = []
      if arrivals.present?
        arrivals.each do |arrival|
          if arrival['trDr'] == '1'
            @dir1Arrivals.push(arrival)
          elsif arrival['trDr'] == '5'
            @dir5Arrivals.push(arrival)
          end
        end
        @stationTitle = @dir1Arrivals.first['staNm']
      else
        @stationTitle = Station.where(map_id: params[:id]).first.name
      end
    end

end
