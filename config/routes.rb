Rails.application.routes.draw do
  
  #会員用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  root to:'public/homes#top'
  get 'about' => 'public/homes#about'
  
  scope module: :public do
    resources :customers, only: [:index, :show, :edit, :update]
    get 'customers/:id/check' => "customers#check", as: 'check'
    patch 'customers/:id/withdrawal' => "customers#withdrawal", as: 'withdrawal'
  end
  
  #管理者用
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
