class SearchController < ApplicationController
  before_action :set_access_token

  def index
    return unless params[:search].present?
    search_results = Yelp.search(params[:search], session[:access_token])
    @search_results = format_search_results(search_results)
  end

  private

  def format_search_results(search_results)
    # normally you wouldn't call `all` here - it would only be favorites for a given user
    # in a certain scope. But there is no user or scope, so calling `all` makes sense
    favorite_ids = Favorite.all.pluck(:yelp_id)
    search_results.each do |item|
      item['favorite'] = favorite_ids.include?(item['id'])
    end
    search_results
  end
end
