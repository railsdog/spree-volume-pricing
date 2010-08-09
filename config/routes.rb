Rails.application.routes.draw do

  namespace :admin do 

    resources :products do 
       resources :variants do
        get :volume_prices, :on => :member
      end
    end

  end

end
