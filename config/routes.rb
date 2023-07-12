Rails.application.routes.draw do

  #会員用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to:'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'customers/:id/check' => "customers#check", as: 'check'
    patch 'customers/:id/withdrawal' => "customers#withdrawal", as: 'withdrawal'

    resources :books
    get 'books/search', to: "books#search"
    resources :reviews do
      resources :review_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get 'tagsearches/search', to: 'tagsearches#search'
    
  end

  #管理者用
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :destroy]
  end

  # ゲストログイン
  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
