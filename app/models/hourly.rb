# frozen_string_literal: true

# A PORO for holding Hourly forecast information
class Hourly
  attr_reader :time, :temperature, :icon

  def initialize(forecast)
    @time = forecast[:time]
    @temperature = forecast[:temperature]
    @icon = forecast[:icon]
  end
end
