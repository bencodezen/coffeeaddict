Coffeeaddict::Application.routes.draw do
  resources :locations, except: [:index, :destroy, :edit]

  root :to => 'locations#new'
end
