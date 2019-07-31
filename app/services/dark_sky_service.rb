# frozen_string_literal: true

# A service to reach out to the Dark Sky API and receive forecast information based on LatLong
class DarkSkyService
  def forecast(lat_long, travel_time = 0)
    lat, long = lat_long
    if travel_time == 0
      get_json("forecast/#{ENV['DARK_SKY_KEY']}/#{lat},#{long}")
    else
      time_stamp = Time.now.to_i + travel_time
      get_json("forecast/#{ENV['DARK_SKY_KEY']}/#{lat},#{long},#{time_stamp}")
    end
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.darksky.net')
  end
end
