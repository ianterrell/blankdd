Blankdd::Application.routes.draw do
  resources :disciplines, :only => [:create] do
    collection do
      get :admin
    end
    member do
      post :ignore
      post :unignore
      post :awesome
      post :good
      post :highlight
    end
  end
  root :to => "disciplines#index"
end
