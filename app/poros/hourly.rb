class Hourly
  attr_reader :time, :temperature, :icon
  
  def initialize(forecast)
    @time = forecast[:time]
    @temperature = forecast[:temperature]
    @icon = forecast[:icon]
  end
end
