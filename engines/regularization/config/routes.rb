Regularization::Engine.routes.draw do


  constraints SubdomainConstraint do
    resources :candidates
  end

  constraints DomainConstraint do
    namespace :portal do 
      resources :candidates
    end
  end
end
