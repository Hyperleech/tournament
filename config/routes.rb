Rails.application.routes.draw do
  get 'stages/auto_generate'
	get 'welcome/index'

	resources :contests 
	resources :games, only: [:edit, :update]
	
	root 'welcome#index'
end
