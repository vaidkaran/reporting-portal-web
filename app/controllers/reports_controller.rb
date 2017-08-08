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
end
