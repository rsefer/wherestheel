module PagesHelper

  def round_time_to_minutes(time)
    roundedDown = (time / 60).floor
    if roundedDown < 2
      'Approaching'
    else
      roundedDown.to_s + ' minutes'
    end
  end

  def time_display(arrivalTime)
    round_time_to_minutes(Time.parse(arrivalTime) - Time.now)
  end

end
