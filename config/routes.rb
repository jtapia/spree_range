Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :ranges do
      resources :categories, controller: 'range_categories'
    end
  end
end