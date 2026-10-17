Rails.application.routes.draw do
  get 'time_loggers/stop', to: 'time_loggers#stop', as: 'time_logger_stop'
  get 'time_loggers/start', to: 'time_loggers#start', as: 'time_logger_start'
  get 'time_loggers/suspend', to: 'time_loggers#suspend', as: 'time_logger_suspend'
  get 'time_loggers/resume', to: 'time_loggers#resume', as: 'time_logger_resume'
  get 'time_loggers/delete', to: 'time_loggers#delete'
  get 'time_loggers', to: 'time_loggers#index', as: 'time_logger_index'

  # have not seen yet
  match 'time_loggers/add_status_transition', to: 'time_loggers#add_status_transition', via: %i[get post]
  match 'time_loggers/delete_status_transition', to: 'time_loggers#delete_status_transition', via: %i[get post]
  match 'time_loggers/show_report', to: 'time_loggers#show_report', via: %i[get post]
end
