Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'home#index', as: :home
  get '/about' => 'home#about'

  resources :projects do
    resources :tasks, except: [:index, :show]
    resources :discussions, shallow: true do
      resources :comments, except: [:index, :show]
    end

  end
end
