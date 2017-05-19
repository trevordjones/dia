class SearchController < ApplicationController
  before_action :set_access_token

  def index
    @search = Yelp.search(params[:search], session[:access_token]) if params[:search].present?
  end
end
