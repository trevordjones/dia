require 'rails_helper'

describe 'favorites#index', type: :feature do
  let(:access_token) { stubbed_access_token['access_token'] }
  let(:favorites) { create_list(:favorite, 5) }

  before do
    stub_authorization_response
    stub_favorites(favorites, access_token)
  end

  it 'renders a list of all favorites' do
    visit favorites_path
    expect(find_all('.list-item').size).to eq(Favorite.count)
  end
end
