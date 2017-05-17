module YelpApiStubs
  def stub_authorization_response
    url = Yelp::API_URL + Yelp::TOKEN_PATH
    params = {
      client_id: Yelp::CLIENT_ID,
      client_secret: Yelp::CLIENT_SECRET,
      grant_type: 'client_credentials'
    }
    stub_request(:post, url)
      .with(body: params)
      .to_return(body: stubbed_access_token.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def stubbed_access_token
    {
      'access_token' => '10328badc2ce157ef1f365aa5453f9975419fff6ea793bce9',
      'expires_in' => 15_551_999,
      'token_type' => 'Bearer'
    }
  end

  def stub_search_response(access_token, search_term, search)
    url = Yelp::API_URL + Yelp::SEARCH_PATH
    headers = {
      'Authorization' => "Bearer #{access_token}",
      'Content-Type' => 'application/json'
    }
    params = {
      term: search_term,
      location: Yelp::LOCATION,
      limit: Yelp::LIMIT
    }
    stub_request(:get, url)
      .with(query: params)
      .to_return(body: search.to_json, headers: headers)
  end

  def stubbed_search(search_term)
    response = []
    10.times { response << stubbed_businesses(search_term) }

    {
      'businesses' => response
    }
  end

  def stubbed_businesses(search_term)
    name = Faker::Company.name
    id = name.downcase.tr(' ', '-')
    {
      'id' => id,
      'name' => name,
      'image_url' => Faker::Avatar.image,
      'categories' => [{'alias' => search_term, 'title' => search_term }]
    }
  end
end
