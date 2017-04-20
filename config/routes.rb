Rails.application.routes.draw do
  devise_for :users

  resources :startups do
    resources :jobs
  end

  resources :jobs do
    resources :resumes
  end

  namespace :admin do
    resources :startups do
      member do
        post :hide
        post :publish
      end
    end
    resources :jobs do
      member do
        post :hide
        post :publish
      end
      resources :resumes
    end
  end

  root "welcome#index"
end
