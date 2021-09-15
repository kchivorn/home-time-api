Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :reservations, only: %i[create update]
    end
  end
end
