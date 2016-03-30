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
  
  resources :users, only: [:new, :create]
  
  post 'users/confirm' => 'users#confirm'
  
  resources :sessions, only: [:new, :create, :destroy]

  #get 'welcome/index'
  root 'welcome#index'
  #get 'welcome/about'
  get 'about' => 'welcome#about'
  #get 'welcome/contact'
  get 'contact' => 'welcome#contact'
  #get 'welcome/faq'
  get 'faq' => 'welcome#faq'

end
