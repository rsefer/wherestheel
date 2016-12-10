Rails.application.routes.draw do

  root 'pages#index'

  get '/s/:id', to: 'pages#station'

  get '/update_station_arrivals', to: 'pages#update_station_arrivals'

end
