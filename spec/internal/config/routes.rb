Rails.application.routes.draw do
  get "one", to: "test#one"
  
  mobile_optional do
    get "two", to: "test#two"
  end
  
  mobile_only do
    get "three", to: "test#three"
  end
end