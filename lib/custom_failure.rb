class CustomFailure < Devise::FailureApp
  def route(_scope)
    :signin_url
  end

  def redirect_url
    signin_path
  end

  def respond
    http_auth? ? http_auth : redirect
  end
end
