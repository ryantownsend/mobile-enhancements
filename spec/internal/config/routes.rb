Rails.application.routes.draw do
  get "one", to: "test#one"
  
  mobile_optional do
    get "two", to: "test#two", as: :optional_mobile
    get "five", to: "test#path_checking"
    get "six", to: "test#redirect_checking"
    get "seven", to: "test#fixed_redirect_checking"
  end
  
  mobile_only do
    get "three", to: "test#three"
    root to: "test#four"
  end
end