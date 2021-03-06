Rails.application.routes.draw do
  get 'friendships/create'
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'tutorials#index'
  get 'tags/:tag', to: 'tutorials#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get '/dashboard', to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/user/activation', to: "user/activation#create"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'
  get '/auth/github/callback', to: 'github_profiles#create'
  delete '/auth/github/cancel', to: 'github_profiles#destroy'
  post '/create_friendship', to: 'friendships#create'

  post '/github_invite', to: 'github_invite#create', as: 'github_invite'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
