class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def set_access_token
    return session[:access_token] if valid_access_token?

    resp = Yelp.access_token
    session[:access_token] = resp['access_token']
    session[:expires] = Time.now.to_i + resp['expires_in']
  end

  def valid_access_token?
    return false if session[:access_token].blank?

    if session[:expires] < Time.now.to_i
      session[:access_token] = nil
      return false
    end
    true
  end
end
