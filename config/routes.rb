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

  get '/' => "home#top"
  get '/room' => "home#room"
  get '/room/create' => "home#create"
  # 作成してないので、良さげなaboutページをあとで作る(優先度低)
  get '/about' => "home#about"

  get "posts/index" => "posts#index"
  get "room/:id" => "posts#room"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
end
