Rails.application.routes.draw do
  root 'purchases#index'
  resources :purchases, only: [:index, :new, :create, :destroy]
  resources :purchases do
    member do 
      get "calculate_sales_tax"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
