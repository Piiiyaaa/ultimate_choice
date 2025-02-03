Rails.application.routes.draw do
  get 'answers/create'
  get 'homes/top'
  devise_for :users
  root "homes#top"
  resources :questions do
    get 'comments', on: :member  # 追加：特定の質問のコメント一覧を取得
    resources :answers, only: [:create] do
      resources :comments, only: [:create]
    end
  end

end
