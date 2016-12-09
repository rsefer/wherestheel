class PagesController < ApplicationController
  before_action :get_station_arrivals, only: [:station]

  def index
  end

  def station
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
      arrivals.each do |arrival|
        if arrival['trDr'] == '1'
          @dir1Arrivals.push(arrival)
        elsif arrival['trDr'] == '5'
          @dir5Arrivals.push(arrival)
        end
      end
    end

end
