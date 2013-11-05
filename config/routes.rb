CodePal::Application.routes.draw do
  resources :users
  resources :projects do
    member do
      get 'workspace', to: 'projects#workspace', as: 'workspace'
      get 'members/new', to: 'project_members#new', as: 'new_members'
      get 'members', to: 'project_members#index', as: 'members'
      post 'members', to: 'project_members#create', as: 'members'
      # resources :project_members, only: [:index, :new]
    end

    resources :users, only: [] do
      member do
        delete 'membership', to: 'project_members#destroy', as: 'members'
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
