CodePal::Application.routes.draw do
  resources :user
  resources :projects do
    member do
      get 'members/new', to: 'project_members#new', as: 'new_members'
      get 'members', to: 'project_members#index', as: 'members_index'
      # resources :project_members, only: [:index, :new]
    end

    resources :user, only: [] do
      member do
        post 'membership', to: 'project_members#create', as: 'members'
        delete 'membership', to: 'project_members#destroy', as: 'members'
        #resources :project_members, only: [:create, :destroy]
      end
    end
  end

  namespace :api do
    resources :projects, only: [:show]
    resources :user, only: [:show] do
      resources :projects, only: [:index]
    end
  end

  root to: 'projects#index'

  get '/login', to: 'session#new', as: 'login'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy', as: 'logout'
end
