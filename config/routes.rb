Rails.application.routes.draw do
  # get 'questions/index'
  # get 'questions/show'
  # get 'questions/new'
  # get 'questions/edit'
  resources :questions

  # get 'advertisements/index'
  # get 'advertisements/show'
  # get 'advertisements/new'
  # get 'advertisements/create'
  resources :advertisements

  #get 'posts/index'
  #get 'posts/show'
  #get 'posts/new'
  #get 'posts/edit'
  resources :posts

  #get 'welcome/index'
  root 'welcome#index'
  #get 'welcome/about'
  get 'about' => 'welcome#about'
  #get 'welcome/contact'
  get 'contact' => 'welcome#contact'
  #get 'welcome/faq'
  get 'faq' => 'welcome#faq'

end
