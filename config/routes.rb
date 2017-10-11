Rails.application.routes.draw do
  resources :repairqs do
  	member do
  		get :test_login, as: :test_login
  		get :todays_sales, as: :todays_sales
      get :sales_report
      get :repairs_report
  	end
  end


  resources :sales_reports do
  	member do
  		get :pull_from_repairq
  		post :post_to_group_me
  	end
  end

  resources :group_me_bots do
  	member do
  		post :test
  		post :report_sales
  	end
  end

  root "repairqs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
