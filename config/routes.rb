Rails.application.routes.draw do
  get  'users/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'		#Added by hand for new users creation (unsubmitted)
  post '/signup',  to: 'users#create'	#Added with RESTful criteria or default criteria (submitted)
  resources :users
end