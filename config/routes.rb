CommeCiCommeCa::Application.routes.draw do
  resources :authentications

  authenticated :user do
    root :to => 'home#play'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "authentications" }

  resources :users
end