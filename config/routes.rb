FlatironKitchen::Application.routes.draw do
  resources :recipes
  resources :ingredients 
  patch 'ingredients/:id/restock', to: 'ingredients#restock', as: 'restock'
end
