Rails.application.routes.draw do
  root 'pages#home'
  get '/home' => 'pages#home'

  #get '/recipes' => 'recipes#index'
  #get '/recipes/new' => 'recipes#new', as: 'new_recipe'
  #post '/recipes' => 'recipes#create'
  #get '/recipes/:id/edit' => 'recipes#edit', as: 'edit_recipe'
  #patch '/recipes/:id' => 'recipes#update'
  #get 'recipes/:id' => 'recipes#show', as: 'recipe'
  #delete '/recipes/:id', to: 'recipes#destroy'

  resources :recipes do
    #синтаксис особо не понятен пока, но это просто post запрос в формате контроллера
    member do
      post 'like'
    end
  end

end
