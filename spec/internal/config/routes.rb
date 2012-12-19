Rails.application.routes.draw do
  resources :guides
  
  mobile_optional do
    resources :items
  end
  
  mobile_only do
    resources :pages
  end
end