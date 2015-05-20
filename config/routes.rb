Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"
  resources :users do
    get :recipes
  end
  resources :recipes do
    resources :ingredients
    get :autocomplete_product_name, :on => :collection
  end
end
