Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :articles, except: :index, shallow: true do
    member do
      resources :comments, only: [:create, :update, :edit, :destroy] do
        member do
          put 'like', to: "comments#upvote"
          put 'dislike', to: "comments#downvote"
        end
      end
      put 'like', to: "articles#upvote"
      put 'dislike', to: "articles#downvote"
    end
  end

  resources :users, only: :show
  resource :search, only: :show
end
