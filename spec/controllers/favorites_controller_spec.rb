require 'rails_helper'

describe FavoritesController, type: :controller do
  let(:yelp_id) { Faker::Company.name.downcase.tr(' ', '-') }

  describe '#create' do
    context 'when create is valid' do
      it 'creates a new favorite' do
        expect { post :create, params: { yelp_id: yelp_id} }
          .to change(Favorite, :count).by(1)

        expect(Favorite.last.yelp_id).to eq(yelp_id)
      end

      it 'returns a successful response' do
        post :create, params: { yelp_id: yelp_id }
        expect(JSON.parse(response.body)['message']).to eq('Favorite saved')
        expect(response.status).to eq(200)
      end
    end

    context 'when create is invalid' do
      # shouldn't ever happen, but better provide the functionality in case

      it 'does not create a new favorite' do
        expect { post :create, params: { yelp_id: nil } }
          .to change(Favorite, :count).by(0)
      end

      it 'returns an error response' do
        post :create, params: { yelp_id: nil }
        expect(JSON.parse(response.body)['error']).to eq('Oops, try again')
        expect(response.status).to eq(422)
      end
    end
  end

  describe '#destroy' do
    before { create(:favorite, yelp_id: yelp_id) }

    context 'when a valid yelp_id is passed' do
      it 'removes a favorite' do
        expect { delete :destroy, params: { id: yelp_id} }
          .to change(Favorite, :count).by(-1)

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['message']).to eq('Removed favorite')
      end
    end

    context 'when an invalid yelp_id is passed' do
      it 'returns an error' do
        expect { delete :destroy, params: { id: ''} }
          .to change(Favorite, :count).by(0)

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('No favorite found')
      end
    end
  end
end
