BookYourSiteWebNew::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'jellystoneniagara#home'

  match "rates" => "jellystoneniagara#rates"
  match "lodging" => "jellystoneniagara#lodging"
    match "lodging/rvcampsites" => "jellystoneniagara#rvcampsites"
    match "lodging/rentals" => "jellystoneniagara#rentals"
  match "familyfun/" => "jellystoneniagara#familyfun"
    match "familyfun/activities" => "jellystoneniagara#activities"
    match "calendar/:date" => "jellystoneniagara#calendar"
      match "description/:data/:data2/:date" => "jellystoneniagara#description"
  match "areaattractions" => "jellystoneniagara#areaattractions"
    match "areamap" => "jellystoneniagara#areamap"
  match "parkmap" => "jellystoneniagara#parkmap"
  match "gallery" => "jellystoneniagara#imagegallery"
  match "specials" => "jellystoneniagara#specials"

  match "putrandomstringhere/:data" => "jellystoneniagara#entry"
  match "putrandomstringhere/" => "jellystoneniagara#entry"
    match "*dbm/base/:data" => "jellystoneniagara#datagrab"
    match "*dbm/:data" => "jellystoneniagara#formgrab"

  
  match "camp/home" => "summerdaycamp#home"
  match "camp/about" => "summerdaycamp#about"
  match "camp/program" => "summerdaycamp#campinfo"
  match "camp/facilities" => "summerdaycamp#facilities"
  match "camp/themes" => "summerdaycamp#themes"
  match "camp/registration" => "summerdaycamp#reg"
  match "camp/gallery" => "summerdaycamp#imagegallery"
  match "camp/operations" => "summerdaycamp#pricinghours"
  match "camp/directions" => "summerdaycamp#directions"
  match "camp/faq" => "summerdaycamp#faq"


  match "contactus-content" => "jellystoneniagara#contactus"
  match ":action" => "jellystoneniagara"

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
