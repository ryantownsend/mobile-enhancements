class TestController < ActionController::Base
  def one
    render text: [action_name, request.format.to_sym].join(", ")
  end
  alias_method :two, :one
  alias_method :three, :one
  alias_method :four, :one
end