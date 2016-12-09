Rails.application.routes.draw do

  root 'pages#index'

  get '/s/:id', to: 'pages#station'

end
