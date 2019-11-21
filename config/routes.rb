Rails.application.routes.draw do
  devise_for :users

  # On définit la page "home" qui aura comme path "root_path"
  #root to: "home#index"

  # On définit la page qui affichera les emails comme page d'accueil et qui aura comme path "root_path"
  root to: "emails#index"

  # Création des routes pour les tasks
  resources :tasks, except: [:show]

  # Création des routes pour les emails
  resources :emails, only: [:create]

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
