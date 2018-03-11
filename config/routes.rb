Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
     # get "/contact_list_url" => "contacts#first_contact_method"
     # get "/contact_list1_url" => "contacts#second_contact_method"
     # get "/contact_list2_url" => "contacts#third_contact_method"
    get "/contacts" => "contacts#index"
    get "/contacts/:id" => "contacts#show"
    post "/contacts" => "contacts#create"
    patch "/contacts/:id" => "contacts#update"
    delete "/contacts/:id" => "contacts#destroy"
  end 
end
