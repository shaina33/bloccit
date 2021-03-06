Rails.application.routes.draw do

  get 'sponsoredposts/show'

  get 'sponsoredposts/new'

  get 'sponsoredposts/edit'

  resources :questions

  resources :advertisements
  
  resources :topics do
    resources :posts, except: [:index]
    resources :sponsoredposts, except: [:index]
  end
  
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post 'up-vote' => 'votes#up_vote', as: :up_vote
    post 'down-vote' => 'votes#down_vote', as: :down_vote
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :topics, only: [] do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:new, :create, :show]
  
  post 'users/confirm' => 'users#confirm'
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :labels, only: [:show]

  #get 'welcome/index'
  root 'welcome#index'
  #get 'welcome/about'
  get 'about' => 'welcome#about'
  #get 'welcome/contact'
  get 'contact' => 'welcome#contact'
  #get 'welcome/faq'
  get 'faq' => 'welcome#faq'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]
      resources :topics, except: [:edit, :new] do
        resources :posts, only: [:update, :destroy]
      end
      post '/topics/:topic_id/posts/create' => 'posts#create'
      resources :posts, only: [:index, :show]
      resources :comments, only: [:index, :show]
    end
  end

end
