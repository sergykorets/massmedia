Rails.application.routes.draw do

  devise_for :authors, :controllers => { registrations: 'registrations' }
  root to: 'blog/posts#index'

  namespace :authors do
    resources :tags, only: [:new, :create, :edit, :update, :destroy]
  	resources :posts do
      resources :comments, only: :index
      member do 
        put 'publish' => 'posts#publish'
        put 'unpublish' => 'posts#unpublish'
      end
    end
  end

  namespace :blog do
    resources :tags, only: [:index, :show] do
      resources :comments, except: [:edit, :update, :show]
    end
    resources :posts, only: [:show, :index] do
      resources :comments, except: [:edit, :update, :show]
    end
  end
  scope module: 'blog' do
  	get 'posts' => 'posts#index', as: :posts
  	get 'posts/:id' => 'posts#show', as: :post
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
