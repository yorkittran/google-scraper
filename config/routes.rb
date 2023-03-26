require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  root 'scraper#index'

  get '/scraper', to: 'scraper#index', as: 'user_root'
  post '/scraper/search', to: 'scraper#search', as: 'search_scraper'

  resources :crawl_results, only: %i[index show] do
    get :source, on: :member
  end
end
