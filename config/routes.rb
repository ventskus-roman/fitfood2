Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"
  resources :users do
    get :recipes
    get :subscribe
    get :unsubscribe
    get :news
  end
  resources :recipes do
    resources :ingredients
    get :autocomplete_product_name, :on => :collection
    member { post :vote }
  end
end
