Rails.application.routes.draw do
  devise_for :users

  resources :startups do
    member do
      post :favorite_startup
      post :dislikes_startup
    end
    resources :jobs
  end

  resources :jobs do
    member do
      post :favorite_job
      post :dislikes_job
    end
    resources :resumes
  end

  namespace :account do
    resources :startups
    resources :jobs
  end

  namespace :admin do
    resources :startups do
      member do
        post :hide
        post :publish
      end

      resources :jobs
    end

    resources :jobs do
      member do
        post :hide
        post :publish
      end
      resources :resumes
    end

    resources :users
  end

  root "welcome#index"
end
