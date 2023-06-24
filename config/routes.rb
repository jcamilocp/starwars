Rails.application.routes.draw do
  devise_for :users

  namespace :v1, defaults: { format: :json } do
    devise_scope :user do
      post 'sign_up', to: 'registrations#create'
      post 'login', to: 'sessions#create'
    end

    resources :planets, only: %i[index show create update destroy]
    resources :people, only: %i[index show create update destroy]
    resources :films, only: %i[index show create update destroy]
  end
end
