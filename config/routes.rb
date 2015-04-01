Healthyeff::Application.routes.draw do

  #added by devise -allan
  #devise_for :users

  # manually add user registration routes to prevent users from registering
  # themselves - Michelle
  # Added :controllers => { :invitations => 'invitations' } for devise invitable
  devise_for :users, :skip => [:registrations], :controllers => { :invitations => 'invitations' } 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/edit' => 'devise/registrations#update', :as => 'user_registration'
  end

  #required for devise to work, redirects to path below after user logs in
  #change home#index to whatever need be -allan
  root to: 'activities#today'

  #Managing employees
  match 'admin/manage' => 'users#manage', :as => :manage
  delete 'manage/:id', to: 'users#destroy', :as => :delete

  #route for single activity -ashley
  match 'today' => 'activities#today', :as => :today
  match 'multiple_days' => 'activities#multiple_days', :as => :multiple_days
  match 'add_activity' => 'activities#add_activity', :as => :add_activity
  match 'add_days' => 'activities#add_days', :as => :add_days
  match 'profile' => 'users#profile', :as => :profile

<<<<<<< HEAD
  # routing for admin views
  get 'admin' => 'admin#index', :as => :admin_list
  get 'admin/pending' => 'admin#pending', :as => :admin_pending
=======
>>>>>>> ff00823d99f24daef18d84d3710584415b4d6c59

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
