class TimeLoggersController < ApplicationController
    unloadable

    def index
        if User.current.nil?
            @user_time_loggers = nil
            @time_loggers = TimeLogger.all
        else
            @user_time_loggers = TimeLogger.where(user_id: User.current.id)
            @time_loggers = TimeLogger.where('user_id != ?', User.current.id)
        end
    end

    def start
        @time_logger = current
        if @time_logger.nil?
            @issue = Issue.find_by_id(params[:issue_id])
            @time_logger = TimeLogger.new({ :issue_id => @issue.id })

            if @time_logger.save
                apply_status_transition(@issue) unless Setting.plugin_time_logger['status_transitions'] == nil
                render_menu
            else
                flash[:error] = l(:start_time_logger_error)
            end
        else
            flash[:error] = l(:time_logger_already_running_error)
        end
    end

    def resume
        @time_logger = current
        if @time_logger.nil? or not @time_logger.paused
            flash[:error] = l(:no_time_logger_suspended)
            redirect_to :back
        else
            @time_logger.started_on = Time.now
            @time_logger.paused = false
            if @time_logger.save
                render_menu
            else
                flash[:error] = l(:resume_time_logger_error)
            end
        end
    end

    def suspend
        @time_logger = current
        if @time_logger.nil? or @time_logger.paused
            flash[:error] = l(:no_time_logger_running)
            redirect_to :back
        else
            @time_logger.time_spent = @time_logger.hours_spent
            @time_logger.paused = true
            if @time_logger.save
                render_menu
            else
                flash[:error] = l(:suspend_time_logger_error)
            end
        end
    end

    def stop
        @time_logger = current
        if @time_logger.nil?
            flash[:error] = l(:no_time_logger_running)
            redirect_to :back
        else
            issue_id = @time_logger.issue_id
            hours = @time_logger.hours_spent.round(2)
            @time_logger.destroy

            redirect_to :controller => 'issues', :action => 'edit', :id => issue_id, :time_entry => { :hours => hours }
        end
    end

    def delete
        time_logger = TimeLogger.find_by_id(params[:id])
        if !time_logger.nil?
            time_logger.destroy
            render :text => l(:time_logger_delete_success)
        else
            render :text => l(:time_logger_delete_fail)
        end
    end

    def render_menu
        @project = Project.find_by_id(params[:project_id])
        @issue = Issue.find_by_id(params[:issue_id])
        render :partial => 'embed_menu'
    end

    def add_status_transition
        transitions = params[:transitions].nil? ? {} : params[:transitions]
        transitions[params[:from_id]] = params[:to_id]

        render :partial => 'status_transition_list', :locals => { :transitions => transitions }
    end

    def delete_status_transition
        transitions = params[:transitions].nil? ? {} : params[:transitions]
        transitions.delete(params[:from_id])

        render :partial => 'status_transition_list', :locals => { :transitions => transitions }
    end

    protected

    def current
        TimeLogger.find_by_user_id(User.current.id)
    end

    def apply_status_transition(issue)
        new_status_id = Setting.plugin_time_logger['status_transitions'][issue.status_id.to_s]
        new_status = IssueStatus.find_by_id(new_status_id)
        if issue.new_statuses_allowed_to(User.current).include?(new_status)
            journal = @issue.init_journal(User.current, notes = l(:time_logger_label_transition_journal))
            @issue.status_id = new_status_id
            @issue.save
        end
    end
end
