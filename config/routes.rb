Rails.application.routes.draw do

  root 'pages#index'

  get '/s/:id', to: 'pages#station'

  get '/about', to: redirect('/', status: 301)

  get '/update_station_arrivals', to: 'pages#update_station_arrivals'
  get '/find_nearest_station', to: 'pages#find_nearest_station'
  get '/display_alerts', to: 'pages#display_alerts'

end
