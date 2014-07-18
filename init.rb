# encoding: utf-8

require 'redmine'

require_dependency 'time_logger_hooks'

Redmine::Plugin.register :time_logger do
    name 'Time Logger'
    author 'Jim McAleer'
    description 'This is a plugin to help log time in Redmine.  The orignal author was Jérémie Delaitre.  I have decided not to follow the route the HicknHack software has gone because it''s too confusing and have spun this off of that.  I do plan on the option to have multiple loggers running for an individual user.'
    version '0.5.0'

    requires_redmine :version_or_higher => '1.1.0'

    settings :default => { 'refresh_rate' => '60', 'status_transitions' => {} }, :partial => 'settings/time_logger'

    permission :view_others_time_loggers, :time_loggers => :index
    permission :delete_others_time_loggers, :time_loggers => :delete

    menu :account_menu, :time_logger_menu, '',
        {
            :caption => '',
            :html => { :id => 'time-logger-menu' },
            :first => true,
            :param => :project_id,
            :if => Proc.new { User.current.logged? }
        }
end

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3
 
if Rails::VERSION::MAJOR >= 3
   ActionDispatch::Callbacks.to_prepare do
     # use require_dependency if you plan to utilize development mode
     require 'time_loggers_patches'
   end
else
  Dispatcher.to_prepare BW_AssetHelpers::PLUGIN_NAME do
    # use require_dependency if you plan to utilize development mode
    require 'time_loggers_patches'
  end
end