Rails.application.routes.draw do
  root 'digital_number#index'

  post 'digital_number/get_numbers',to:"digital_number#get_numbers"

end
