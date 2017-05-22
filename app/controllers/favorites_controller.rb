class FavoritesController < ApplicationController
  before_action :set_access_token

  def index
    search_results = Yelp.search_favorite_reviews(session[:access_token])
    @favorites = format_search_results(search_results)
  end

  def create
    favorite = Favorite.new(yelp_id: params[:yelp_id])
    if favorite.save
      render json: { message: 'Favorite saved' }, status: 200
    else
      render json: { error: 'Oops, try again' }, status: 422
    end
  end

  def destroy
    favorite = Favorite.find_by(yelp_id: params[:id])
    if favorite.present?
      favorite.destroy
      render json: { message: 'Removed favorite' }, status: 200
    else
      render json: { error: 'No favorite found' }, status: 422
    end
  end

  private

  def format_search_results(search_results)
    search_results.each do |review|
      review['favorite'] = true
    end
  end
end
