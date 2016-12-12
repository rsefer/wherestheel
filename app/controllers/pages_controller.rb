class PagesController < ApplicationController
  before_action :get_station_arrivals, only: [:station, :update_station_arrivals]
  before_action :get_route_alerts, only: [:display_alerts]

  def index
  end

  def station
    @station = Station.where(map_id: params[:id]).first
  end

  def update_station_arrivals
    respond_to do |format|
      format.js
    end
  end

  def find_nearest_station
    user_location = [params[:lat].to_f, params[:lng].to_f]
    nearest = Station.near(user_location, 1, :units => :mi).limit(1)
    @nearestStation = nearest.first
  end

  def display_alerts
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
      end
    end

    def get_route_alerts
      alertRequest = "http://www.transitchicago.com/api/1.0/alerts.aspx?outputType=JSON&stationid=#{params[:id]}"
      alertResponse = HTTParty.get alertRequest
      alertJson = ActiveSupport::JSON
      @alerts = []
      if alertJson.decode(alertResponse.body)['CTAAlerts']['Alert']
        alertsRaw = alertJson.decode(alertResponse.body)['CTAAlerts']['Alert']
        alertsRaw.each do |alertRaw|
          # Severity Scores:
          # 0-39 = Accessibility, informational, planned
          # 40-59 = "Minor delays and reroutes"
          # 60-79 = "Significant delays and reroutes"
          # 80-99 = "Major delays and service disruptions"
          if alertRaw['SeverityScore'].to_i >= 40
            @alerts.push({ :url => alertRaw['AlertURL']['#cdata-section'], :description => alertRaw['ShortDescription'] })
          end
        end
      end
    end

end
