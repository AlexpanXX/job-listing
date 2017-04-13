Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    resources :resumes
  end

  root "jobs#index"
end
