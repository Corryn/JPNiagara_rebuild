BookYourSiteWebNew::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'content#homepage'
  match '' => 'content#homepage'
  match 'mobile' => 'content#homepage_mobile'
  match 'about-us' => 'content#about-us'
  match 'contact-us' => 'content#contact-us'
  match 'support/iphone' => 'support#iphone'
  match 'support/android' => 'support#android'
  match 'mobile/sales' => 'sales#camp_owners_mobile'
  match 'sales/camp_owners' => 'sales#camp_owners'
  match 'search' => 'content#search'
  match 'mobile/search' => 'content#search_mobile'
  match 'camping-places/:id' => 'content#campingplaces'
  match 'admin/:action' => 'admin'
  match 'param.xml' => 'content#param'
  match 'images.xml' => 'content#images'
  match 'mobile/:id' => 'content#park_mobile'
  match ':id' => 'content#home' #THIS AND OTHER ROUTES BEGINNING WITH :ID NEED TO BE MODIFIED (maybe park/:id) as it causes different erros (such as routing to park with id 404 when trying to display 404.html)
  match ':id/:action' => 'content'
  match ':id/param.xml' => 'content#param'
  

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
