class TestController < ActionController::Base
  def one
    render text: [action_name, request.format.to_sym].join(", ")
  end
  alias_method :two, :one
  alias_method :three, :one
  alias_method :four, :one
  
  def path_checking
    render text: optional_mobile_url
  end
  
  def redirect_checking
    redirect_to(optional_mobile_url)
  end
  
  def fixed_redirect_checking
    redirect_to(mobile_url(optional_mobile_url))
  end
end