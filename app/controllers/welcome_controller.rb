class WelcomeController < ApplicationController
  def index
    redirect_to user_home_url if auth_token_valid?
    redirect_to org_user_home_url if org_auth_token_valid?
  end
end
