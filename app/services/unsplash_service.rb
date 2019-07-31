# frozen_string_literal: true

# A service to reach out to the Unsplash photo hosting API based on location
class UnsplashService
  def search(location)
    get_json('search/photos', query: "#{location} nature")
  end

  private

  def get_json(url, params)
    response = conn.get(url, default_params.merge(params))
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.adapter(Faraday.default_adapter)
      f.headers['Accept-Version'] = 'v1'
      f.headers['Authorization'] = "Client-ID #{ENV['UNSPLASH_KEY']}"
    end
  end

  def default_params
    {
      orientation: 'landscape'
    }
  end
end
