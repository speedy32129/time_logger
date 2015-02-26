module TimeLoggersHelper
    def issue_from_id(issue_id)
        Issue.find_by_id(issue_id)
    end

    def user_from_id(user_id)
        User.find_by_id(user_id)
    end
end
