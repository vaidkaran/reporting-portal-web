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
      @report = JSON(res)
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
