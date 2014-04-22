BookYourSiteWebNew::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'jellystoneniagara#home'

  match "rates" => "jellystoneniagara#rates"
  match "lodging/" => "jellystoneniagara#lodging"
    match "lodging/rvcampsites" => "jellystoneniagara#rvcampsites"
    match "lodging/rentals" => "jellystoneniagara#rentals"
    match "lodging/moreinfo/:data" => "jellystoneniagara#moreinfo"
    match "/getSite" => "jellystoneniagara#getSite"
  match "familyfun/" => "jellystoneniagara#familyfun"
  match "activities" => "jellystoneniagara#activities"
  match "calendar/:date" => "jellystoneniagara#calendar"
    match "description/:data/:data2/:date" => "jellystoneniagara#description"
  match "areaattractions" => "jellystoneniagara#areaattractions"
    match "tours" => "jellystoneniagara#tours"
    match "attractions" => "jellystoneniagara#attractions"
    match "areamap" => "jellystoneniagara#areamap"
  match "brochure" => redirect("#{Resource.where(:use => "brochure").first[:path]}")
  match "parkmap" => "jellystoneniagara#parkmap"
    match "parkmapinfo/:data" => "jellystoneniagara#parkmapinfo"
    match "parkmapfacility/:data" => "jellystoneniagara#parkmapfacility"
  match "camp" => "jellystoneniagara#camp"
  match "imagegallery" => "jellystoneniagara#imagegallery"
  match "gallery" => "jellystoneniagara#gallery"
  match "specials" => "jellystoneniagara#specials"
  match "day_camp" => redirect("/camp")
  match "class_trip" => redirect("/classtrips")

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

  match "admin/menu" => "jellystoneniagara#menu"
  match "admin/login" => "jellystoneniagara#login"
  match "admin/comments" => "jellystoneniagara#comments"
  match "admin/test" => "jellystoneniagara#test"
  match "admin/entry/:data" => "jellystoneniagara#entry"
  match "admin/entry/" => "jellystoneniagara#entry"
    match "admin/dbm/base/:data" => "jellystoneniagara#datagrab"
    match "admin/dbm/:data" => "jellystoneniagara#formgrab"

  
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
