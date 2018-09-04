Jobdog::Application.routes.draw do

  match "home" => "users#home", as: :home, via: :get
  match "about" => "sessions#about", as: :about, via: :get

  match "jobs/:id/close" => "jobs#close_job", as: :close_job, via: :put
  match "jobs/:id/complete" => "jobs#complete_job", as: :complete_job, via: :put

  match "auth/google_oauth2/callback" => "sessions#oauth_login"
  match "auth/failure" => "sessions#oauth_failure"
  
  match "notifications/:id/mark_as_read" => "notifications#mark_as_read", as: :read_notification, via: :put
  
  resources :users, only: [:create, :new, :update, :destroy, :edit] do
    resource :profile, only: :show
    resources :bids, only: [:index]
    resources :awards, only: [:index]
  end
  
  resource :session, only: [:create, :new, :destroy] 
  
  resources :jobs do
    resources :bids, only: [:create, :destroy]
    resources :awards, only: [:create, :destroy]
    member do
      resource :rating, only: [:edit, :update]
    end
  end
  
  resources :messages, only: :create
  
  root to: "sessions#front"
  
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
  #     member dox
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
