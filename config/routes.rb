Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/about' => 'home#about'

  resources :favorites, only: :index
  resources :users, only: [:create, :new, :edit, :update] do
    resources :passwords, only: [:edit, :update]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end
  resources :projects, shallow: true do
    resources :tasks, except: [:index, :show]
    resources :favorites, only: [:create, :destroy]
    resources :discussions, shallow: true do
      resources :comments, except: [:index, :show]
    end
  end
end
