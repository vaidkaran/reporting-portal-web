class SuperadminSettingsController < ApplicationController
  before_action :authenticate_user
  before_action :only_superadmins_allowed

  def index
  end

  def organisations
    res = RestClient.get "#{api_base_url}/organisations", auth_headers
    @orgs = JSON(res)
  end

  def create_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/create_superadmin", user_email_params, auth_headers
    res = JSON(res)
    if res['success'] == 'true'
      redirect_to superadmin_settings_index_url
    else
      redirect_to superadmin_settings_index_url
    end
  end

  def destroy_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/destroy_superadmin", user_email_params, auth_headers
    res = JSON(res)
    if res['success'] == 'true'
      redirect_to superadmin_settings_index_url
    else
      redirect_to superadmin_settings_index_url
    end
  end

  def create_organisation
    res = RestClient.post "#{api_base_url}/organisations", {name: params[:org_name]}, auth_headers
    res = JSON(res)
    if res['success'] == 'true'
      redirect_to superadmin_settings_index_url
    else
      redirect_to superadmin_settings_index_url
    end
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
end
