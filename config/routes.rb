Rails.application.routes.draw do
  get "transaction/:wallet_id/:type_id", to: "transactions#new", as: "transaction_new"
  post "transaction/:wallet_id/:type_id", to: "transactions#create", as: "transaction_create"

  get "transactions", to: "transactions#index"

  # resources :wallets do
  #   member do
  #     get 'balance', action: :get_balance
  #     get 'transactions', action: :get_transactions
  #     get 'transaction', action: :transaction
  #     post 'transaction', action: :create_transaction
  #   end
  # end

  resources :users do
    member do
      get 'balance', action: :get_balance
      get 'transactions', action: :get_transactions
    end
  end

  resources :teams do
    member do
      get 'balance', action: :get_balance
      get 'transactions', action: :get_transactions
    end
  end

  resources :stocks do
    member do
      get 'balance', action: :get_balance
      get 'transactions', action: :get_transactions
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "wallets#index"
end
