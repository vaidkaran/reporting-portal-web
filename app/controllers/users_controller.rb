class UsersController < ApplicationController
  before_action :authenticate_user, only: :home

  def home
    res = RestClient.get "#{api_base_url}/projects", auth_headers
    if res.code==200
      @projects = JSON(res)
    end
  end

  def sign_in
    begin
      res = RestClient.post "#{api_base_url}/auth/sign_in", user_params
      if res.code==200
        set_auth_cookies(res.headers)
        redirect_to user_home_url
      else
        flash[:notice] = 'Email and password don\'t match.'
        redirect_to root_url
      end
    rescue
      flash[:notice] = 'Email and password don\'t match.'
      redirect_to root_url
    end
  end

  def sign_up
    begin
      res = RestClient.post "#{api_base_url}/auth", user_params
      if res.code==200
        set_auth_cookies(res.headers)
        redirect_to user_home_url
        # with user_id
      else
        # Display a flash message
        redirect_to root_url
      end
    rescue
      # Display a flash message
      redirect_to root_url
    end
  end

  def sign_out
    if auth_token_valid?
      delete_auth_cookies
      redirect_to root_url
    end
  end

  private
  def user_params
    params.permit(:email, :password).to_h
  end
end
