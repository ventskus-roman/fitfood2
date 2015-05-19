Rails.application.routes.draw do
  root "recipes#index"
  resources :recipes do
    resources :ingredients
    get :autocomplete_product_name, :on => :collection
  end
end
