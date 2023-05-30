Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { sessions: 'users/sessions' }, path: '',
                     path_names: { sign_in: 'login', sign_out: 'logout' }, as: 'user_sessions'
  root to: 'pages#home'

  resources :genres
  resources :users
  resources :authors
  resources :reader_cards
  resources :libraries
  resources :books
  get '/home', to: 'pages#home'
  get 'downloads/csv', to: 'downloader#csv', as: 'downloader_csv'
  get 'downloads/pdf', to: 'downloader#pdf', as: 'downloader_pdf'
  get '/libraries/:id/download_report', to: 'downloader#pdf_library', as: 'downloader_pdf_library'
  get '/users/:id/download_report', to: 'downloader#pdf_user', as: 'downloader_pdf_user'

end
