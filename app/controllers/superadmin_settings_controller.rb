class SuperadminSettingsController < ApplicationController
  before_action :authenticate_user

  def index
  end

  def create_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/create_superadmin", email_params, auth_headers
    res = JSON(res)
    if res['success'] == 'true'
      redirect_to superadmin_settings_index_url
    else
      redirect_to superadmin_settings_index_url
    end
  end

  def destroy_superadmin
    res = RestClient.post "#{api_base_url}/superadmin_settings/destroy_superadmin", email_params, auth_headers
    res = JSON(res)
    if res['success'] == 'true'
      redirect_to superadmin_settings_index_url
    else
      redirect_to superadmin_settings_index_url
    end
  end

  private
  def email_params
    return {email: params[:email]}
  end
end
