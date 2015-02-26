Rails.application.routes.draw do
  match 'time_loggers/stop', :to => "time_loggers#stop", via: [:get, :post]
  match 'time_loggers/start', :to => "time_loggers#start", via: [:get, :post]
  match 'time_loggers/suspend', :to => "time_loggers#suspend", via: [:get, :post]
  match 'time_loggers/resume', :to => "time_loggers#resume", via: [:get, :post]
  match 'time_loggers/render_menu', :to => "time_loggers#render_menu", via: [:get, :post]
  match 'time_loggers/add_status_transition', :to => "time_loggers#add_status_transition", via: [:get, :post]
  match 'time_loggers/delete_status_transition', :to => "time_loggers#delete_status_transition", via: [:get, :post]
  match 'time_loggers/show_report', :to => "time_loggers#show_report", via: [:get, :post]
  match 'time_loggers/delete', :to => "time_loggers#delete", via: [:get, :post]
  match 'time_loggers', :to => "time_loggers#index", via: [:get, :post]
end
