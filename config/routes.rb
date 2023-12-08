# config/routes.rb
Rails.application.routes.draw do
  get 'contact_forms/new'
  get 'contact_forms/create'
  resources :news
  resources :contact_forms, only: [:new, :create]
  #get 'adoption_posts/index', to: 'adoption_posts#index'
  resources :adoption_posts
  resources :adoption_posts do
    member do
      patch 'adopted'
      get 'contact'
    end
  end
  root 'home#index'

  #------------------Rutas para la creación de usuarios utilizando RegistrationsController ----------------------#
  devise_for :users, controllers: { registrations: 'registrations' }
  #-----------------------------------------------------------------------------------------------------------------#

  #-------------------- Rutas para la creación de usuarios utilizando UsersController --------------------------#
  get 'users/search', to: 'users#search', as: 'users_search'
  get 'users/show', to: 'users#show', as: 'users_show'
  get 'users/edit', to: 'registrations#edit', as: 'edit_user'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  #------------------------------------------------------------------------------------------------------#

  #--------------- Rutas para la creación de turnos utilizando AppointmentController -----------------------#
  resources :appointments do
    member do
      patch 'update_state'
      patch 'update_date'
    end
  end
  get 'appointments/confirmation/:id', to: 'appointments#confirmation', as: 'confirmation_appointment'
  #get 'appointments/show:user_id', to: 'appointments#show', as: 'show_appointment'
  #get 'appointments/list/:user_id', to: 'appointments#list', as: 'list_appointments'
  #---------------------------------------------------------------------------------------------------------#

  #---------------- Rutas para la creación de perros utilizando DogsController -----------------------------#
  resources :dogs, only: [:new, :create, :show, :index]
  #---------------------------------------------------------------------------------------------------------#


  resources :contact_posts

  get '/paseadores_cuidadores', to: 'contact_posts#index', as: 'paseadores_cuidadores'

end
