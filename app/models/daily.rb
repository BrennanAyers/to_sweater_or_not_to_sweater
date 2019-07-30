# frozen_string_literal: true

# A PORO for holding Daily forecast information
class Daily
  attr_reader :time,
              :icon,
              :precip_probability,
              :precip_type,
              :temperature_high,
              :temperature_low

  def initialize(forecast)
    @time = forecast[:time]
    @icon = forecast[:icon]
    @precip_probability = forecast[:precipProbability]
    @precip_type = forecast[:precipType]
    @temperature_high = forecast[:temperatureHigh]
    @temperature_low = forecast[:temperatureLow]
  end
end
