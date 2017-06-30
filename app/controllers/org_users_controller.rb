class OrgUsersController < ApplicationController
  before_action :authenticate_org_user, only: :home

  def home
  end

  def sign_in
    begin
      res = RestClient.post api_base_url+'/org_auth/sign_in', org_user_params
      if res.code==200 && !res.body['error'] # See if && can be replace with and
        set_auth_cookies(res.headers)
        redirect_to org_user_home_url
        # with organisation_id
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
    if org_auth_token_valid?
      delete_auth_cookies
    end
    redirect_to root_url
  end

  private
  def org_user_params
    params.permit(:email, :password).to_h
  end
end
