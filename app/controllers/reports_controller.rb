class ReportsController < ApplicationController
  def index
    res = RestClient.get "#{api_base_url}/reports?test_category_id=#{params[:test_category_id]}", auth_headers
    if res.code==200
      @reports = JSON(res)
    end
  end

  def show
    res = RestClient.get "#{api_base_url}/reports/#{params[:id]}", auth_headers
    if res.code==200
      @report = JSON(res, symbolize_names: true)
      test_category = RestClient.get "#{api_base_url}/test_categories/#{@report[:test_category_id]}", auth_headers
      test_category = JSON(test_category, symbolize_names: true)
      if test_category[:report_type] == 'testng'
        render 'testng'
      end
    end
  end

  def create
    res = RestClient.post "#{api_base_url}/upload/junit", create_report_params, auth_headers
    if res.code==200
      flash[:notice] = 'Report uploaded successfully'
    else
      flash[:notice] = 'Something went wrong. Could not upload report'
    end
    redirect_to reports_url(test_category_id: params[:test_category_id])
  end

  private
  def create_report_params
    {test_category_id: params[:test_category_id], upload: params[:xml_upload].tempfile}
  end
end
