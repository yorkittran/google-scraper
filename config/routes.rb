Rails.application.routes.draw do
  devise_for :users
  root 'scraper#index'

  get '/scraper', to: 'scraper#index', as: 'user_root'
  post '/scraper/search', to: 'scraper#search', as: 'search_scraper'
  resources :crawl_results, only: %i[index show]
end
