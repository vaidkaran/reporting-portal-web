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
  post 'org_users/create_org_user' => 'org_users#create_org_user', as: 'org_admin_create_org_user'
  get 'org_users/admin_settings' => 'org_users#admin_settings', as: 'org_admin_settings'

  # TODO: Fix the names (superadmin_settings_index can be just superadmin_settings)
  get 'superadmin_settings/index' => 'superadmin_settings#index', as: 'superadmin_settings_index'
  get 'superadmin_settings/organisations' => 'superadmin_settings#organisations', as: 'superadmin_settings_organisations'
  post 'superadmin_settings/create_superadmin' => 'superadmin_settings#create_superadmin', as: 'create_superadmin'
  post 'superadmin_settings/destroy_superadmin' => 'superadmin_settings#destroy_superadmin', as: 'destroy_superadmin'
  post 'superadmin_settings/create_organisation' => 'superadmin_settings#create_organisation', as: 'create_organisation'
  post 'superadmin_settings/create_org_user' => 'superadmin_settings#create_org_user', as: 'superadmin_create_org_user'

  get 'org_settings/index' => 'org_settings#index', as: 'org_settings'
  post 'org_settings/create_org_user' => 'org_settings#create_org_user', as: 'org_settings_create_org_user'
  post 'org_settings/create_project' => 'org_settings#create_project', as: 'org_settings_create_project'
  post 'org_settings/create_test_category' => 'org_settings#create_test_category', as: 'org_settings_create_test_category'

  get 'user_settings/index' => 'user_settings#index', as: 'user_settings'
  post 'user_settings/create_project' => 'user_settings#create_project', as: 'user_settings_create_project'
  post 'user_settings/create_test_category' => 'user_settings#create_test_category', as: 'user_settings_create_test_category'

  resources :reports

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
