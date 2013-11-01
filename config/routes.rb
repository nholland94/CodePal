CodePal::Application.routes.draw do
	resources :user
	
	get '/login', to: 'session#new', as: 'login'
	post '/login', to: 'session#create'
	delete '/logout', to: 'session#destroy', as: 'logout'
end
