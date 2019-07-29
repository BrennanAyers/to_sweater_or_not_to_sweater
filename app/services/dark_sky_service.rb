# frozen_string_literal: true

# A service to reach out to the Dark Sky API and receive forecast information based on LatLong
class DarkSkyService
  def forecast(lat_long)
    lat, long = lat_long
    get_json("forecast/#{ENV['DARK_SKY_KEY']}/#{lat},#{long}")
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
