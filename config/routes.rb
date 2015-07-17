Rails.application.routes.draw do

  scope '(:locale)', locale: /fr|nl/ do

    get "thank_you",       to: "home#thank_you"

    post "clinicians/:id", to: "patients#create", as: "clinician_patients"

    get  "patients/payment_completed/:phone", to: "patients#completed"
    post "patients/payment_done_s2p",         to: "patients#done"

    resources :clinicians, only: [:new, :create] do

      get   "patients/:token", to: "patients#show"
      patch "patients/:id",    to: "patients#update", as: "update_patient"

      resources :patients, only: [:edit]
    end

    get  "clinicians/:token", to: "clinicians#show", as: "clinician_show"

    root 'home#index'

  end

end

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
