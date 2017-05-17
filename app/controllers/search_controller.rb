class SearchController < ApplicationController
  before_action :set_access_token

  def index
    @search = Yelp.search('pizza', session[:access_token])
  end
end
