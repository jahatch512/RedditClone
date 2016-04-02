Rails.application.routes.draw do
  resources :users
  resources :posts, except: :index
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy

end
