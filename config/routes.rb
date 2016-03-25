Rails.application.routes.draw do

  resources :questions

  resources :advertisements
  
  resources :topics do
    resources :posts, except: [:index]
  end

  #get 'welcome/index'
  root 'welcome#index'
  #get 'welcome/about'
  get 'about' => 'welcome#about'
  #get 'welcome/contact'
  get 'contact' => 'welcome#contact'
  #get 'welcome/faq'
  get 'faq' => 'welcome#faq'

end
