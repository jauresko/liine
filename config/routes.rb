Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :travels do
    resources :bookings do
      resources :reviews, only: [:new, :create, :edit, :update]
    end
  end

  resources :purchases do
    resources :orders do
      resources :review_orders, only: [:new, :create, :edit, :update]
    end
  end

  get 'myprofile/mypurchase', to: 'purchases#mypurchase', as: 'mypurchase'
  get 'myprofile/mytravel', to: 'travels#mytravel', as: 'mytravel'
  get 'myprofile/order', to: 'orders#display_resa', as: 'myorder'
  get 'myprofile/booking', to: 'bookings#display_resa', as: 'mybooking'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
