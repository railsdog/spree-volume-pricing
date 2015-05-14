Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :products do
      resources :variants do
        get :volume_prices, on: :member
      end
    end

    delete '/volume_prices/:id', to: 'volume_prices#destroy', as: :volume_price
    resources :volume_price_models
  end
end
