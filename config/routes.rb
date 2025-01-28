Rails.application.routes.draw do
  get 'answers/create'
  get 'homes/top'
  devise_for :users
  root "homes#top"
  resources :questions do
    resources :answers, only: [:create] do
      resources :comments, only: [:create]
    end
  end

end
