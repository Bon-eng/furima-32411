Rails.application.routes.draw do

  devise_for :users

  root to: "items#index"

  #購入情報を作る機能の実装なのでindexとcreateアクションのルーティングをネストする
  resources :items do
    resources :orders, only: [:index, :create]
  end

end