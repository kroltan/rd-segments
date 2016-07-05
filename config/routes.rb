Rails.application.routes.draw do

	devise_for :admins
	
	resources :contacts
	resources :segments do
		match 'query', on: :collection, via: [:get, :post]
		get 'query', on: :member
	end

	root 'index#index'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
