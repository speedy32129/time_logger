if Rails::VERSION::MAJOR >= 3
  Rails.application.routes.draw do
    match 'time_loggers/stop'   , :to => "time_loggers#stop"
    match 'time_loggers/start'  , :to => "time_loggers#start"
    match 'time_loggers/suspend', :to => "time_loggers#suspend"
    match 'time_loggers/resume' , :to => "time_loggers#resume"
    match 'time_loggers/render_menu', :to => "time_loggers#render_menu"
    match 'time_loggers/add_status_transition', :to => "time_loggers#add_status_transition"
    match 'time_loggers/delete_status_transition', :to => "time_loggers#delete_status_transition"
    match 'time_loggers/show_report', :to => "time_loggers#show_report"
    match 'time_loggers/delete', :to => "time_loggers#delete"
    match 'time_loggers' , :to => "time_loggers#index"
  end
else
  ActionController::Routing::Routes.draw do |map|
    map.connect 'time_loggers/stop', :controller => 'time_loggers', :action => 'stop'
    map.connect 'time_loggers/start', :controller => 'time_loggers', :action => 'start'
    map.connect 'time_loggers/suspend', :controller => 'time_loggers', :action => 'suspend'
    map.connect 'time_loggers/resume', :controller => 'time_loggers', :action => 'resume'
    map.connect 'time_loggers/render_menu', :controller => 'time_loggers', :action => 'render_menu'
    map.connect 'time_loggers/add_status_transition', :controller => 'time_loggers', :action => 'add_status_transition'
    map.connect 'time_loggers/delete_status_transition', :controller => 'time_loggers', :action => 'delete_status_transition'
    map.connect 'time_loggers/show_report', :controller => 'time_loggers', :action => 'show_report'
    map.connect 'time_loggers/delete', :controller => 'time_loggers', :action => 'delete'
    map.connect 'time_loggers', :controller => 'time_loggers', :action => 'index'
  end
end

