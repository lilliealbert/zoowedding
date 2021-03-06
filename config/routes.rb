Zoowedding::Application.routes.draw do
  root 'static_pages#home'

  get '/lodging' => 'static_pages#lodging'
  get '/transport' => 'static_pages#transport'
  get '/events' => 'static_pages#events'
  get '/registries' => 'static_pages#registries'
  get '/faq' => 'static_pages#faq'

  get '/5' => 'anniversary#five'

  get '/admin' => 'admin#index'
  post '/send_invitations' => 'admin#send_invitations', as: "send_invitations"
  post '/send_reminders' => 'admin#send_reminders', as: "send_reminders"
  post '/send_shuttle' => 'admin#send_shuttle', as: "send_shuttle"

  get 'invitations/:external_id' => 'invitations#edit', as: "secretive"
  get 'invitations/:external_id/shuttle/new' => 'shuttle#new', as: "secretive_shuttle"

  resources :invitations do
    resources :shuttle, only: :create
  end

  resources :guests

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
