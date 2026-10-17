class TimeLoggersController < ApplicationController
  before_action :find_time_logger, :only => [:resume, :suspend, :stop, :delete]
  after_action :apply_status_transition, only: :start,
               if: proc { Setting.plugin_time_logger['status_transitions'].present? }

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
    head :bad_request and return if params[:issue_id].nil? || TimeLogger.exists?(:user_id => User.current.id)

    @time_logger = TimeLogger.new(:issue_id => params[:issue_id])
    @time_logger.started_on = Time.current

    respond_to do |format|
      if @time_logger.save
        format.js {render :partial => 'time_loggers/start'}
      else
        head :internal_server_error
      end
    end
  end

  def resume
    if @time_logger.try(:paused)
      @time_logger.started_on = Time.current
      @time_logger.paused = false

      respond_to do |format|
        if @time_logger.save
          format.js {render :partial => 'time_loggers/resume'}
        else
          format.js {head :internal_server_error}
        end
      end
    else
      # time logger already running or not found
      head :bad_request
    end
  end

  def suspend
    # time logger is present and it is paused
    if @time_logger.try(:paused) == false
      @time_logger.time_spent = @time_logger.seconds_spent
      @time_logger.paused = true

      respond_to do |format|
        if @time_logger.save
          format.js {render :partial => 'time_loggers/suspend'}
        else
          format.js {head :internal_server_error}
        end
      end
    else
      # no time logger or it's not paused
      head :bad_request
    end
  end

  def stop
    issue_id = @time_logger.issue_id
    hours = @time_logger.hours_spent
    @time_logger.destroy

    redirect_to_new_time_entry = Setting.plugin_time_logger['redirect_to_new_time_entry']

    if redirect_to_new_time_entry
      redirect_to controller: 'timelog',
                  action: 'new',
                  issue_id: issue_id,
                  time_entry: { hours: hours }
    else
      redirect_to controller: 'issues',
                  action: 'edit',
                  id: issue_id,
                  time_entry: { hours: hours }
    end
  end

  def delete
    @time_logger.destroy
    flash[:notice] = l(:time_logger_delete_success)
    respond_to do |format|
      format.html {redirect_to time_logger_index_path}
    end
  end

  private

  def apply_status_transition
    issue = @time_logger.issue
    new_status_id = Setting.plugin_time_logger['status_transitions'][issue.status_id.to_s]
    new_status = IssueStatus.find_by_id(new_status_id)
    if issue.new_statuses_allowed_to(User.current).include?(new_status)
      issue.init_journal(User.current, l(:time_logger_label_transition_journal))
      issue.status_id = new_status_id
      issue.save
    end
  end

  def find_time_logger
    @time_logger = TimeLogger.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:error] = l(:no_time_logger)
        redirect_back_or_default(request.referer, :referer => true)
      end
      format.js {head :not_found}
    end
  end
end
