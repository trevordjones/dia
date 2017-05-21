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
end
