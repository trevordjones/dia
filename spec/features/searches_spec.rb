require 'rails_helper'

describe 'search#index', type: :feature do
  let(:search_term) { Faker::Food.ingredient }
  let(:access_token) { stubbed_access_token['access_token'] }
  let(:search_results) { stubbed_search }

  before do
    stub_authorization_response
    stub_search_response(access_token, search_term, search_results)
  end

  context 'when no search is performed' do
    it 'renders no list' do
      visit root_path
      expect(find_all('.list-item').empty?).to be_truthy
    end
  end

  context 'when a search is performed' do
    it 'renders a list of search items' do
      visit root_path
      fill_in 'Search', with: search_term
      click_button 'Search'
      expect(find_all('.list-item').empty?).to be_falsey
    end
  end

  context 'when there is a search that has favorites' do
    before do
      search_results['businesses'][0..1].each do |item|
        create(:favorite, yelp_id: item['id'])
      end
    end

    it 'renders a list with an Unfavorite button' do
      visit root_path
      fill_in 'Search', with: search_term
      click_button 'Search'
      expect(find_all('a', text: 'Unfavorite').size).to eq(Favorite.count)
    end
  end

  # Side note: I'm not doing a feature test for favoriting since I am using JavaScript
  # I felt adding selenium webdriver would be overkill for the scope of this project
end
