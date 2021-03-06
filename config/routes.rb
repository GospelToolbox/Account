Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  use_doorkeeper

  devise_scope :user do
    get '/invitation', to: "welcome#accept_invitation"
  end

  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }

  resources :organizations

  namespace :api do
    namespace :v1 do
      resources :users
      resources :organizations do 
        post 'invite', on: :member
      end

      get 'profile', to: 'profile#show'
    end
  end

  root 'profile#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
