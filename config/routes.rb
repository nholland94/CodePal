CodePal::Application.routes.draw do
	resources :user
	resources :projects

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
