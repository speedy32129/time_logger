require 'active_support/concern'

module TimeLoggerApplicationHelperPatch
  extend ActiveSupport::Concern

  included do
    def time_logger_for(user)
      TimeLogger.find_by(:user_id => user.id)
    end

    def status_from_id(status_id)
      IssueStatus.find_by(:id => status_id)
    end

    def statuses_list
      IssueStatus.all
    end

    def to_status_options(statuses)
      options_from_collection_for_select(statuses, 'id', 'name')
    end

    def new_transition_from_options(transitions)
      statuses = []
      statuses_list.each do |status|
        statuses << status unless transitions.key?(status.id.to_s)
        # if !transitions.has_key?(status.id.to_s)
        #    statuses << status
        # end
      end
      to_status_options(statuses)
    end

    def new_transition_to_options
      to_status_options(statuses_list)
    end

    def suspend_link(time_logger)
      link_to(
        '',
        time_logger_suspend_path(:id => time_logger.id),
        :class => 'icon-action icon-pause-action',
        :id => 'time-logger-suspend-btn',
        :title => l(:suspend_time_logger),
        :onclick => %{pause_timer();},
        :remote => true
      )
    end

    def resume_link(time_logger)
      link_to(
        '',
        time_logger_resume_path(:id => time_logger.id),
        :class => 'icon-action icon-start-action',
        :id => 'time-logger-resume-btn',
        :title => l(:resume_time_logger),
        :remote => true
      )

    end
  end
end

unless ApplicationHelper.included_modules.include? TimeLoggerApplicationHelperPatch
  ApplicationHelper.include TimeLoggerApplicationHelperPatch
end
