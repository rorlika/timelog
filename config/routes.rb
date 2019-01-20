Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'log/create', to: 'logs#create'
  get 'reports', to: 'projects#reports'
  post 'project/create', to: 'projects#create'
end
