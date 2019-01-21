Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root '/api-docs'

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'
      post 'log/create', to: 'logs#create'
      get 'project/report', to: 'projects#report'
      post 'project/create', to: 'projects#create'
    end
  end
end
