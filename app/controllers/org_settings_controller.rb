class OrgSettingsController < ApplicationController
  before_action :authenticate_org_user
  before_action :only_org_user_admin

  def index
    res = RestClient.get "#{api_base_url}/projects", auth_headers
    if res.code==200
      @projects = JSON(res)
    end
  end

  def create_org_user
    res = RestClient.post "#{api_base_url}/org_auth", create_org_user_params, auth_headers
    if res.code==200
      flash[:notice] = 'Successfully created org user'
    else
      flash[:notice] = 'Something went wrong. Could not create org user'
    end
    redirect_to org_settings_url
  end

  def create_project
    res = RestClient.post "#{api_base_url}/projects", project_params, auth_headers
    if res.code==200
      flash[:notice] = "Successfully created a new project"
    else
      flash[:notice] = "Could not create the project"
    end
    redirect_to org_settings_url
  end

  def create_test_category
    res = RestClient.post "#{api_base_url}/test_categories", test_category_params, auth_headers
    if res.code==200
      flash[:notice] = "Successfully created a new test category"
    else
      flash[:notice] = "Could not create the test category"
    end
    redirect_to org_settings_url
  end

  private
  def create_org_user_params
    return {organisation_id: current_org_user[:organisation_id], email: params[:email], password: params[:password], admin: false}
  end

  def only_org_user_admin
    unless current_org_user[:admin]
      render json: {'error': 'Unauthorized'}
    end
  end

  def project_params
    {name: params[:name]}
  end

  def test_category_params
    {name: params[:name], project_id: params[:project_id]}
  end
end
