class TestController < ActionController::Base
  def one
    render text: __method__
  end
  alias_method :two, :one
  alias_method :three, :one
end