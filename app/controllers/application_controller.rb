class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'rest-client'

  protect_from_forgery with: :exception
end
