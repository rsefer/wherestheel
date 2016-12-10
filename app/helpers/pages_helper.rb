module PagesHelper

  def round_time_to_minutes(time)
    roundedDown = (time / 60).floor
    if roundedDown < 2
      'Approaching'
    else
      roundedDown.to_s + ' minutes'
    end
  end

  def minutes_to_arrival_display(arrivalTime)
    round_time_to_minutes(Time.parse(arrivalTime) - Time.now)
  end

  def time_display(time)
    time.strftime("%l:%M%P").gsub(/\s+/, '')
  end

  def no_trains_message
    '<p>No Trains Available</p>'.html_safe
  end

end
