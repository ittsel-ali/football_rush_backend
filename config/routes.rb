Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rushings, only: :index do 
    collection do
      get :download_csv
    end
  end
end
