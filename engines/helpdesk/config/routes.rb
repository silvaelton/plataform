Helpdesk::Engine.routes.draw do
  
  resources :qualifications
  resources :order_services
  resources :statuses
  resources :order_services do 
  	resources :monitor_service_orders
  end	
end
