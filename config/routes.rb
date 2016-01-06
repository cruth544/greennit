Rails.application.routes.draw do
  root 'posts#index'

  resources :sessions, only: [:new, :destroy]
  post 'sessions/new' => 'sessions#create', as: :create_session
  get 'sessions/destroy' => 'sessions#destroy', as: :destroy_session

  resources :users
  get 'posts/all' => 'posts#all', as: :posts_all
  resources :posts
  resources :subgreens, only: [:index, :show, :new, :create, :edit]
  resources :comments, only: [:show, :create, :edit, :update, :destroy]
  post 'comments/new' => 'comments#create', as: :create_comment

  namespace :api do
    resources :media, only: [:index, :show]
  end

  # get 'comments/index'

  # get 'comments/show'

  # get 'comments/new'

  # get 'comments/create'

  # get 'comments/edit'

  # get 'comments/destroy'

  # get 'posts/index'

  # get 'posts/show'

  # get 'posts/new'

  # get 'posts/create'

  # get 'posts/edit'

  # get 'posts/destroy'

  # get 'sessions/new'

  # get 'users/index'

  # get 'users/show'

  # get 'users/new'

  # get 'users/edit'

  # get 'users/destroy'

  # You can have the root of your site routed with "root"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


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
