WashDepot::Application.routes.draw do
  get "pages/index"

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
    post 'add_picture_to_request', to: 'requests#add_picture_to_request'
    delete 'remove_picture', to: 'requests#remove_picture'

    get 'get_locations', to: 'lists#get_locations'
    get 'get_problem_areas', to: 'lists#get_problem_areas'
    get 'get_statuses', to: 'lists#get_statuses'
    get 'get_available_importance', to: 'lists#get_available_importance'
  end

  resources :locations
  resources :problem_areas, only: :index
  resources :statuses
  resources :requests
  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#index.html'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
