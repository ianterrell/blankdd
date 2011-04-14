Blankdd::Application.routes.draw do
  resources :disciplines, :only => [:create]
  root :to => "disciplines#index"
end
