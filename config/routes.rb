Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to:  'general#index' 

  # post関連作成時(index意外)はこのコメントアウトを外して実装してください
  # controllerは docker-compose run --rm web rails g controller users/hoge で作成
  # 参考記事 https://qiita.com/ryosuketter/items/9240d8c2561b5989f049
  # namespace :users do
  #   resource :hoge
  # end

  # indexは記述せず、general#indexに実装してください
end
