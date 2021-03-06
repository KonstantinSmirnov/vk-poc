Rails.application.routes.draw do
  root "pages#index"

  get 'pages/index'
  get 'pages/authorize'
  get 'pages/get_communities_list'
  post 'pages/select_community'
  get 'pages/configure_community1'
  get 'pages/configure_community2'
  get 'pages/add_product'

  resource :setting
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
