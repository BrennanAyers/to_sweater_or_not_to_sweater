# frozen_string_literal: true

# A Service to access the Google Maps API for geocoding
class GoogleMapsService
  def geocodes(address)
    get_json("geocode/json", {address: address})
  end

  private

  def get_json(url, params)
    response = conn.get(url, default_params.merge(params))
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://maps.googleapis.com/maps/api")
  end

  def default_params
    {
      key: ENV['GOOGLE_MAPS_KEY']
    }
  end
end
