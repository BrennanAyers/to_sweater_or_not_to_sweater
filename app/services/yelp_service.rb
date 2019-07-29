# frozen_string_literal: true

# A service to reach out to the Yelp API for restaurant information
class YelpService
  def businesses(location, travel_time, term)
    open_at = Time.now.to_i + travel_time
    get_json('businesses/search', { location: location, open_at: open_at, term: term })
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.yelp.com/v3') do |f|
      f.adapter Faraday.default_adapter
      f.headers['Authorization'] = 'Bearer ' + ENV['YELP_KEY']
    end
  end
end
