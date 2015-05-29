Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"
  get 'tags/:tag', to: 'recipes#index', as: :tag
  resources :users do
    get :recipes
    get :subscribe
    get :unsubscribe
    get :news
  end
  resources :recipes do
    resources :ingredients
    get :autocomplete_product_name, :on => :collection
    get :tags, :on => :collection
    member { post :vote }
  end
end
