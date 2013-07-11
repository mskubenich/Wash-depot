WashDepot::Application.routes.draw do

  devise_for :users do
    namespace :api do
      post 'sessions' => 'sessions#create', :as => 'login'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
  end

  namespace :api do
    resources :users , only: :index

    post 'get_requests_list', to: 'requests#index'
    post 'create_request', to: 'requests#create'
    post 'get_request', to: 'requests#show'
    post 'update_request', to: 'requests#update'
    delete 'remove_request', to: 'requests#destroy'

    get 'get_lists', to: 'lists#get_lists'
  end

  resources :problem_areas
  resources :locations
  resources :statuses
  resources :problem_areas
  resources :statuses
  resources :requests
  resources :clients
  post '/change_user_role', :to => "clients#change_user_role"
  resources :importances

  root :to => 'requests#index'

end
