require 'rails_helper'

describe Yelp do
  describe '.access_token' do
    before { stub_authorization_response }
    it 'returns a hash with an access_token and expires_in' do
      expect(Yelp.access_token).to eq(stubbed_access_token)
    end
  end

  describe '.search' do
    let(:access_token) { stubbed_access_token['access_token'] }
    let(:search_term) { Faker::Food.ingredient }
    let(:search_results) { stubbed_search }

    before { stub_search_response(access_token, search_term, search_results) }

    it 'returns yelp search results' do
      resp = Yelp.search(search_term, access_token)
      expect(resp).to eq(search_results['businesses'])
    end
  end

  describe '.search_favorite_reviews' do
    let(:access_token) { stubbed_access_token['access_token'] }
    let(:favorites) { create_list(:favorite, 5) }

    before { stub_favorites(favorites, access_token) }

    it 'returns favorites that match user favorites' do
      resp = Yelp.search_favorite_reviews(access_token)
      resp_ids = resp.map { |review| review['id'] }
      expect(resp_ids).to match_array(Favorite.all.pluck(:yelp_id))
    end
  end
end
