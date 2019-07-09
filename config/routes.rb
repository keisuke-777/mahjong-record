Rails.application.routes.draw do
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get 'signup' => "users#signup"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  post "users/finish/:room_number/:sum/:matches/:win/:rate" => "users#finish"

  get '/' => "home#top"
  get '/room' => "home#room"
  get '/room/create' => "home#create"
  # 作成してないので、良さげなaboutページをあとで作る(優先度低)
  get '/about' => "home#about"

  get "room/search" => "posts#search"
  get "room/:id/:row" => "posts#room_edit"
  post "posts/edit_row/:id/:row" => "posts#edit_row"
  get "room/:id" => "posts#room"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  post "posts/name/:number" => "posts#name"
  post "posts/join/:place/:room_number" => "posts#join"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  post "posts/mov_room" => "posts#mov_room"
end
