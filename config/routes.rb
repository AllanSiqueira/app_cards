Rails.application.routes.draw do
  root to: 'home#index'
  post 'result', to: 'home#result'
end
