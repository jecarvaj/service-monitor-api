Rails.application.routes.draw do
  get '/check', to: 'application#check_api'

  resources :services do
    post '/', to: 'services#create', as: 'create_service'
    get '/:week', to: 'services#show'
    post '/:week/update_availability', to: 'services#update_availability_and_confirm_shifts'
  end

  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
end
