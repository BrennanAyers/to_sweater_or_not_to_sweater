# frozen_string_literal: true

# A PORO for holding Current forecast information
class Currently
  attr_reader :summary, :icon, :precip_probability, :precip_type, :temperature, :apparent_temperature, :humidity, :uv_index, :visibility, :temperature_high, :temperature_low

  def initialize(full_forecast, daily_forecast)
    @summary = full_forecast[:summary]
    @icon = full_forecast[:icon]
    @precip_probability = full_forecast[:precipProbability]
    @precip_type = full_forecast[:precipType]
    @temperature = full_forecast[:temperature]
    @apparent_temperature = full_forecast[:apparentTemperature]
    @humidity = full_forecast[:humidity]
    @uv_index = uv_index_processed(full_forecast[:uvIndex])
    @visibility = full_forecast[:visibility]
    @temperature_high = daily_forecast[:temperatureHigh]
    @temperature_low = daily_forecast[:temperatureLow]
  end

  def uv_index_processed(uv_index_number)
    case uv_index_number
    when 0..2; "#{uv_index_number} (low)"
    when 3..5; "#{uv_index_number} (moderate)"
    when 6..7; "#{uv_index_number} (high)"
    when 8..10; "#{uv_index_number} (very high)"
    when 11..100; "#{uv_index_number} (extreme)"
    end
  end
end
