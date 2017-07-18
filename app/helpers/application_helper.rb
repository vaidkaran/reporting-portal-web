module ApplicationHelper
  def api_base_url
    'http://localhost:8080'
  end

  def auth_headers
    h = {}
    h['access-token'] = cookies.encrypted[:access_token]
    h['token-type']   = cookies.encrypted[:token_type]
    h['expiry']       = cookies.encrypted[:expiry]
    h['client']       = cookies.encrypted[:client]
    h['uid']          = cookies.encrypted[:uid]
    return h
  end

  def auth_token_valid?
    begin
      res = RestClient.get "#{api_base_url}/auth/validate_token", auth_token_validation_params
      if res.code==200
        @user_uid = cookies.encrypted[:uid]
        @user_superadmin = JSON(res.body)['data']['superadmin']
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

  def authenticate_user
    if !auth_token_valid?
      render 'welcome/index'
    end
  end

  def org_auth_token_valid?
    begin
      res = RestClient.get "#{api_base_url}/org_auth/validate_token", auth_token_validation_params
      if res.code==200
        @org_user_uid ||= cookies.encrypted[:uid]
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

  def authenticate_org_user
    if !org_auth_token_valid?
      render 'welcome/index'
    end
  end

  def set_auth_cookies res_headers
    cookies.encrypted[:access_token] = res_headers[:access_token]
    cookies.encrypted[:token_type]   = res_headers[:token_type]
    cookies.encrypted[:expiry]       = res_headers[:expiry]
    cookies.encrypted[:client]       = res_headers[:client]
    cookies.encrypted[:uid]          = res_headers[:uid]
  end

  def delete_auth_cookies
    cookies.delete 'access-token'
    cookies.delete 'token-type'
    cookies.delete 'expiry'
    cookies.delete 'uid'
    cookies.delete 'client'
  end

################################
  # Private methods
################################
  private
  def auth_token_validation_params
    token_validation_params = {'access-token' => cookies.encrypted[:access_token],
                               'uid' => cookies.encrypted[:uid],
                               'client' => cookies.encrypted[:client]}
  end
end
