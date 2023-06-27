Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    devise_for :users,
               singular: :user,
               path: '',
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
      get :people, on: :member
      get :films, on: :member
      post :films, on: :member, to: 'planets#add_film'
      delete '/films/:film_id', to: 'planets#delete_film'
    end
    resources :people, only: %i[index show create update destroy] do
      get :films, on: :member
      post :films, on: :member, to: 'people#add_film'
      delete '/films/:film_id', to: 'people#delete_film'
    end
    resources :films, only: %i[index show create update destroy] do
      get :planets, on: :member
      post :planets, on: :member, to: 'films#add_planet'
      delete '/planets/:planet_id', to: 'films#delete_planet'

      get :people, on: :member
      post :people, on: :member, to: 'films#add_people'
      delete '/people/:people_id', to: 'films#delete_people'
    end
  end
end
