Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/receiver/leaderboard/:token' => 'receiver#post'
  get '/receiver/leaderboard' => 'receiver#get'

  mount ActionCable.server, at: '/cable'
end
