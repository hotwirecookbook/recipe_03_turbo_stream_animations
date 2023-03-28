Rails.application.routes.draw do
  root to: 'online#index'
  devise_for :users
end
