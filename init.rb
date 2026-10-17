require File.expand_path 'lib/time_logger_hooks', __dir__
require File.expand_path 'lib/time_logger_application_helper_patch', __dir__

Redmine::Plugin.register :time_logger do
  name 'Time Logger'
  author 'Jérémie Delaitre, Jim McAleer, Dmitry Makurin, Dmitry Beloglazov'
  description 'Time logger is a Redmine plugin to ease time tracking when working on an issue'
  url 'https://github.com/midnightdim/time_logger'
  version '2026.10.0'

  requires_redmine version_or_higher: '7.0.0'

  settings default: { refresh_rate: '60', status_transitions: {}, redirect_to_new_time_entry: 'off' }, partial: 'settings/time_logger'

  permission :view_others_time_loggers, time_loggers: :index
  permission :delete_others_time_loggers, time_loggers: :delete

  # Redmine 7 renders the account menu inside the avatar dropdown, so the time logger
  # is not an account menu item anymore: time_loggers/_update_menu adds it to the top menu bar.
end
