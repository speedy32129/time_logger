if Rails::VERSION::MAJOR >= 4
  Rails.application.routes.draw do
    match 'time_loggers/stop', to: 'time_loggers#stop', via: %i[get post]
    match 'time_loggers/start', to: 'time_loggers#start', via: %i[get post]
    match 'time_loggers/suspend', to: 'time_loggers#suspend', via: %i[get post]
    match 'time_loggers/resume', to: 'time_loggers#resume', via: %i[get post]
    match 'time_loggers/render_menu', to: 'time_loggers#render_menu', via: %i[get post]
    match 'time_loggers/current_timer', to: 'time_loggers#current_timer', via: %i[get post]
    match 'time_loggers/add_status_transition', to: 'time_loggers#add_status_transition', via: %i[get post]
    match 'time_loggers/delete_status_transition', to: 'time_loggers#delete_status_transition', via: %i[get post]
    match 'time_loggers/show_report', to: 'time_loggers#show_report', via: %i[get post]
    match 'time_loggers/delete', to: 'time_loggers#delete', via: %i[get post]
    match 'time_loggers', to: 'time_loggers#index', via: %i[get post]
  end
elsif Rails::VERSION::MAJOR >= 3
  Rails.application.routes.draw do
    match 'time_loggers/stop', to: 'time_loggers#stop'
    match 'time_loggers/start', to: 'time_loggers#start'
    match 'time_loggers/suspend', to: 'time_loggers#suspend'
    match 'time_loggers/resume', to: 'time_loggers#resume'
    match 'time_loggers/render_menu', to: 'time_loggers#render_menu'
    match 'time_loggers/current_timer', to: 'time_loggers#current_timer'
    match 'time_loggers/add_status_transition', to: 'time_loggers#add_status_transition'
    match 'time_loggers/delete_status_transition', to: 'time_loggers#delete_status_transition'
    match 'time_loggers/show_report', to: 'time_loggers#show_report'
    match 'time_loggers/delete', to: 'time_loggers#delete'
    match 'time_loggers', to: 'time_loggers#index'
  end
end
