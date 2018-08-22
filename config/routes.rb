Rails.application.routes.draw do
  root 'homepage#index'
  
  get 'services/index'
end
