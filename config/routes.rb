Rails.application.routes.draw do
  mount SimpleJwtAuth::Engine, at: "/auth"
  namespace :api do
    resources :books do
      collection do
        get :search
      end
    end
  end
end
