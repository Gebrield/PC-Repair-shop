MyITCRM2::Application.routes.draw do

  resources :roles
  resources :permissions
  resources :permittables

  resources :users do
    collection do
      put :edit_profile
      put :update_profile
      put :register
    end
      resources :invoices, :work_orders
  end

  resources :pages
  resources :page_categories do
    get :page_category_name, :on => :collection
  end


  resources :statuses
  resources :priority_lists


  resources :work_orders do
    collection do
      put :close
      put :assign
    end
    resources :replies, :invoices, :tasks
  end
  resources :invoices do
     resources :product_invoice_lines, :service_invoice_lines
    end

  resources :settings do
    collection do
      get :index
      put :edit
    end
  end

  resources :product_categories do
    get :product_category_name, :on => :collection
  end

  resources :user_sessions

  resources :suppliers
  resources :products
  resources :service_rates
  resources :replies, :only => [:show, :edit, :update]
  resources :tasks, :only => [:index, :show, :edit, :update]
  match '/login' => 'user_sessions#new', :to => :login, via: [:get, :post]
  match '/logout' => 'user_sessions#destroy', :to => :logout, via: [:get,:post]
  match '/register' => 'users#register', :to => :register, via: [:get, :post]
  match '/clients' => 'users#clients', :to => :clients, via: [:get, :post]
  match '/employees' => 'users#employees', :to => :employees, via: [:get, :post]
  match 'profile/:id' => 'users#edit_profile', :to => :my_account, via: [:get, :post]
  match 'work_orders/:id/close' => 'work_orders#close', :to => :close, via: [:get, :post]
  match 'work_order/:id/assign' => 'work_orders#assign', :to => :assign, via: [:get, :post]
  match 'settings/edit' => 'settings#edit', :to => :edit, via: [:get, :post]

  match 'help/:page_id' => 'help#show', via: [:get, :post]
  get '*page_category/:id' => 'pages#show', :only => [:show]

#  Ensure these are last in this list and before the root route

  #resources :pages, :only => [:index, :new, :edit]
#  resources :pages, path: "", except: [:index, :new, :create]

#  map.root :register
#  root :to => 'pages#show',:permalink => 'home'
  root :to => 'user_sessions#new'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
