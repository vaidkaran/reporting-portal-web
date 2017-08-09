class OrgUsersController < ApplicationController
  before_action :authenticate_org_user, only: [:home, :create_org_user, :admin_settings]
  before_action :only_org_user_admin, only: [:create_org_user, :admin_settings]

  def home
    res = RestClient.get "#{api_base_url}/projects", auth_headers
    if res.code==200
      @projects = JSON(res)
    end
  end

  def admin_settings
  end

  def create_org_user
    res = RestClient.post "#{api_base_url}/org_auth", create_org_user_params, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully created org user'
    else
      flash[:notice] = 'Something went wrong. Could not create org user'
    end
    redirect_to org_admin_settings_url
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

  def create_org_user_params
    return {organisation_id: current_org_user[:organisation_id], email: params[:email], password: params[:password], admin: false}
  end

  def only_org_user_admin
    unless current_org_user[:admin]
      render json: {'error': 'Unauthorized'}
    end
  end
end
