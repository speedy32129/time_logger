# This class hooks into Redmine's View Listeners in order to add content to the page
class TimeLoggerHooks < Redmine::Hook::ViewListener
    render_on :view_layouts_base_body_bottom, :partial => 'time_loggers/update_menu'
    render_on :view_issues_context_menu_start, :partial => 'time_loggers/update_context'

    def view_layouts_base_html_head(context = {})
        css = stylesheet_link_tag 'time_logger.css', :plugin => 'time_logger'
        js = javascript_include_tag 'time_logger.js', :plugin => 'time_logger'
        css + js
    end
end
