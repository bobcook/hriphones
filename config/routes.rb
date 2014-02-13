Rails.application.routes.draw do
  mount Telephony::Engine, :at => "zestphone"

  root to: 'widget_host#index'
  
  resources :zestphone do
    post :telephony
  end
end
