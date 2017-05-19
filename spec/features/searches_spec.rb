require 'rails_helper'

describe 'search#index', type: :feature do
  before { stub_authorization_response }

  context 'when no search is performed' do
    it 'renders no list' do
      visit root_path
      expect(find_all('.list-item').empty?).to be_truthy
    end
  end

  context 'when a search is performed' do
    let(:search_term) { Faker::Food.ingredient }
    let(:access_token) { stubbed_access_token['access_token'] }
    let(:search_results) { stubbed_search(search_term) }
    before { stub_search_response(access_token, search_term, search_results) }

    it 'renders a list of search items' do
      visit root_path
      fill_in 'Search', with: search_term
      click_button 'Search'
      expect(find_all('.list-item').empty?).to be_falsey
    end
  end
end
