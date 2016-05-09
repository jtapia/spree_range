Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :ranges
  end
end