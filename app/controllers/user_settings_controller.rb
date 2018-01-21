class UserSettingsController < ApplicationController
  before_action :authenticate_user

  def index
    res = RestClient.get "#{api_base_url}/projects", auth_headers
    if res.code==200
      @projects = JSON(res)
    end
  end

  def create_project
    res = RestClient.post "#{api_base_url}/projects", project_params, auth_headers
    if res.code==200
      flash[:notice] = "Successfully created a new project"
    else
      flash[:notice] = "Could not create the project"
    end
    redirect_to user_settings_url
  end

  def create_test_category
    res = RestClient.post "#{api_base_url}/test_categories", test_category_params, auth_headers
    if res.code==200
      flash[:notice] = "Successfully created a new test category"
    else
      flash[:notice] = "Could not create the test category"
    end
    redirect_to user_settings_url
  end

  private
  def project_params
    {name: params[:name]}
  end

  def test_category_params
    {name: params[:name], project_id: params[:project_id], report_type: params[:report_type], report_format: params[:report_format]}
  end
end
