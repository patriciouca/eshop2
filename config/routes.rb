Rails.application.routes.draw do

  root :to => 'catalog#index'
  get 'about' => 'about#index'
  get 'admin/producer' => 'admin/producer#index'
  get 'admin/director' => 'admin/director#index'
  get 'admin/movie' => 'admin/movie#index'
  get 'admin/order' => 'admin/order#index'
  get 'checkout' => 'checkout#index'

  get 'about/index'

  get 'admin/movie/new'
  post 'admin/movie/create'
  get 'admin/movie/edit'
  post 'admin/movie/update'
  post 'admin/movie/destroy'
  get 'admin/movie/show'
  get 'admin/movie/show/:id' => 'admin/movie#show'
  get 'admin/movie/index'

  get 'admin/producer/new'
  post 'admin/producer/create'
  get 'admin/producer/edit'
  post 'admin/producer/update'
  post 'admin/producer/destroy'
  get 'admin/producer/show'
  get 'admin/producer/show/:id' => 'admin/producer#show'
  get 'admin/producer/index'

    post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'



  get 'admin/director/new'
  post 'admin/director/create'
  get 'admin/director/edit'
  post 'admin/director/update'
  post 'admin/director/destroy'
  get 'admin/director/show'
  get 'admin/director/show/:id' => 'admin/producer#show'
  get 'admin/director/index'

  get 'catalog/show'
  get 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'

    get 'checkout/index'
  post 'checkout/submit_order'
  get 'checkout/thank_you'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
