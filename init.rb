# encoding: utf-8

require 'redmine'

require_dependency 'time_logger_hooks'

# workaround helping rails to find the helper-methods
require File.join(File.dirname(__FILE__), 'app/helpers/application_helper.rb')


Redmine::Plugin.register :time_logger do
    name 'Time Logger'
    author 'Jim McAleer'
    description 'The orignal author was Jérémie Delaitre.'
    url 'https://github.com/speedy32129/time_logger'
    version '0.5.4.0'


    #fix for contect menus

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
