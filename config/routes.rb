Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  get 'not_found', to: 'not_found#index', as: :not_found

  match '/404', to: 'not_found#index', via: :all
  match '/500', to: 'not_found#index', via: :all

  devise_scope :user do
    unauthenticated :user do
      root 'users/sessions#new', as: :unauthenticated_root
    end

    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    authenticate :user do
      resources :event_types
      post 'users/check_existence', to: 'users#check_existence'
      resources :users do
        resources :events, only: [:index, :create, :edit, :update, :destroy], controller: 'users/events'
      end
      resources :events
      resources :work_centers do
        resources :events, only: [:index, :show], controller: 'work_centers/events'
      end
      resources :managers
      resources :doctors
      resources :receptionists
      resources :doctor_filters, only: :index
    end

  end

end
