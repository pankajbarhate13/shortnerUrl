Rails.application.routes.draw do
  resources :short_urls do
    member do
      get :update_clicks
    end
  end

  root 'short_urls#index'
  # get "purchase_type/:type" => "projects#purchase_type", as: :purchase_type
end
