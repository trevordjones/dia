class Yelp
  CLIENT_ID = Rails.application.secrets.client_id
  CLIENT_SECRET = Rails.application.secrets.client_secret
  SEARCH_PATH = '/v3/businesses/search'.freeze
  REVIEW_PATH = '/v3/businesses/'.freeze
  TOKEN_PATH = '/oauth2/token'.freeze
  API_URL = 'https://api.yelp.com'.freeze
  LOCATION = 'New York'.freeze
  LIMIT = 10

  class << self
    def access_token
      url = API_URL + TOKEN_PATH
      params = {
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        grant_type: 'client_credentials'
      }
      response = HTTParty.post(url, body: params)
      response.parsed_response
    end

    def search(term, access_token)
      url = API_URL + SEARCH_PATH
      header = { 'Authorization' => "Bearer #{access_token}" }
      params = {
        term: term,
        location: LOCATION,
        limit: LIMIT
      }
      response = HTTParty.get(url, query: params, headers: header)
      response.parsed_response['businesses']
    end

    def search_favorite_reviews(access_token)
      favorite_ids = Favorite.all.pluck(:yelp_id)
      favorites = []
      favorite_ids.each do |id|
        url = API_URL + REVIEW_PATH + id
        header = { 'Authorization' => "Bearer #{access_token}" }
        favorites << HTTParty.get(url, headers: header).parsed_response
      end
      favorites
    end
  end
end
