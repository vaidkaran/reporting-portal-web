Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :users, only: [:index, :create]
  post 'users/sign_in' => 'users#sign_in', as: 'user_sign_in'
  post 'users/sign_up' => 'users#sign_up', as: 'user_sign_up'
  get 'users/sign_out' => 'users#sign_out', as: 'user_sign_out'
  get 'users/home' => 'users#home', as: 'user_home'

  post 'org_users/sign_in' => 'org_users#sign_in', as: 'org_user_sign_in'
  post 'org_users/sign_up' => 'org_users#sign_up', as: 'org_user_sign_up'
  get 'org_users/sign_out' => 'org_users#sign_out', as: 'org_user_sign_out'
  get 'org_users/home' => 'org_users#home', as: 'org_user_home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
