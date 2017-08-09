class OrgUsersController < ApplicationController
 before_action :authenticate_org_user, only: [:home]

  def home
    res = RestClient.get "#{api_base_url}/projects", auth_headers
    if res.code==200
      @projects = JSON(res)
    end
  end

  def sign_in
    begin
      res = RestClient.post api_base_url+'/org_auth/sign_in', org_user_params
      if res.code==200 && !res.body['error'] # See if && can be replace with and
        set_auth_cookies(res.headers)
        redirect_to org_user_home_url
      else
        flash[:notice] = 'Could not sign in'
        redirect_to root_url
      end
    rescue
      flash[:notice] = 'Something went wrong. Could not sign in'
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
