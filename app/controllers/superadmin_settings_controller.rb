class SuperadminSettingsController < ApplicationController
  before_action :authenticate_user
  before_action :only_superadmins_allowed

  def index
    res = RestClient.get "#{api_base_url}/organisations", auth_headers
    @orgs = JSON(res)
  end

  def create_org_user
    res = RestClient.post "#{api_base_url}/org_auth", org_user_params, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully created org user'
    else
      flash[:notice] = 'Something went wrong. Could not create org user'
    end
    redirect_to superadmin_settings_index_url
  end

  def create_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/create_superadmin", user_email_params, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully created superadmin'
    else
      flash[:notice] = 'Something went wrong. Could not create superadmin'
    end
    redirect_to superadmin_settings_index_url
  end

  def destroy_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/destroy_superadmin", user_email_params, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully destroyed superadmin'
    else
      flash[:notice] = 'Something went wrong. Could not destroy superadmin'
    end
    redirect_to superadmin_settings_index_url
  end

  def create_organisation
    res = RestClient.post "#{api_base_url}/organisations", {name: params[:org_name]}, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully created organisation'
    else
      flash[:notice] = 'Something went wrong. Could not create organisation'
    end
    redirect_to superadmin_settings_index_url
  end

  private
  def user_email_params
    return {email: params[:email]}
  end

  def only_superadmins_allowed
    unless @user_superadmin
      render json: {message: 'Unauthorized access'}
    end
  end

  def org_user_params
    h = {organisation_id: params[:org_id].to_i, email: params[:email], password: params[:password]}
    h[:admin] = true if params[:admin]=='1'
    return h
  end
end
