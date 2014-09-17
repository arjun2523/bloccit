Rails.application.routes.draw do
  devise_for :users
   resources :users, only: [:update]
   resources :topics do
     resources :posts, except: [:index]
     resources :comments, only: [:create, :destroy]
   end
  resources :posts do
     resources :comments, only: [:create, :destroy]

     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down-vote' => 'votes#down_vote', as: :down_vote
  end  
   
  resources :votes, only: [:create]
  # POST /votes
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
