Fourinarow::Application.routes.draw do
  resources :games

  get "home/index"

  root :to => 'home#index'

  controller :games do
    match 'games/:id' => 'games#droppiece', :via => :post
    match 'games/:id' => 'games#show', :via => :get
    match 'games/:id/join', :to => 'games#join', :via => :get, :as => :join_game
  end

end
