Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    devise_for :users, singular: :user,  path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'v1/sessions',
      registrations: 'v1/registrations'
    }

    resources :planets, only: %i[index show create update destroy] do
      get :films, on: :member
      post :films, on: :member, to: 'planets#add_film'
    end
    resources :people, only: %i[index show create update destroy]
    resources :films, only: %i[index show create update destroy]
  end
end
