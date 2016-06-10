module ApplicationHelper

    def time_logger_for(user)
        TimeLogger.find_by_user_id(user.id)
    end

    def issue_from_id(issue_id)
        Issue.find_by_id(issue_id)
    end

    def user_from_id(user_id)
        User.find_by_id(user_id)
    end

    def status_from_id(status_id)
        IssueStatus.find_by_id(status_id)
    end

    def statuses_list
        IssueStatus.all
    end

    def to_status_options(statuses)
        options_from_collection_for_select(statuses, 'id', 'name')
    end

    def new_transition_from_options(transitions)
        statuses = []
        for status in statuses_list
            statuses << status unless transitions.has_key?(status.id.to_s)
            #if !transitions.has_key?(status.id.to_s)
            #    statuses << status
            #end
        end
        to_status_options(statuses)
    end

    def new_transition_to_options
        to_status_options(statuses_list)
    end

    def global_allowed_to?(user, action)
        return false if user.nil?

        projects = Project.all
        for p in projects
            if user.allowed_to?(action, p)
                return true
            end
        end

        return false
    end
end