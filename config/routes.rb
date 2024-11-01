
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  # 開発環境で、/letter_openerにアクセスした時に、メールの送信BOXを表示させる
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

end
