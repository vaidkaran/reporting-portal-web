class TestCategoriesController < ApplicationController
  def create
    res = RestClient.post "#{api_base_url}/test_categories", test_category_params, auth_headers
    if res.code==200
      flash[:notice] = "Successfully created a new test category"
    else
      flash[:notice] = "Could not create the test category"
    end
    redirect_to org_admin_settings_url
  end

  private
  def test_category_params
    {name: params[:name]}
  end
end
