# Helper access from the model
class TLHelper
    include Singleton
    include TimeLoggersHelper
end

def help
    TLHelper.instance
end

class TimeLogger < ActiveRecord::Base
    belongs_to :user
    has_one :issue

    attr_accessible :issue_id
    validates_presence_of :issue_id

    def initialize(arguments = nil)
        super(arguments)
        self.user_id = User.current.id
        self.started_on = Time.now
        self.time_spent = 0.0
        self.paused = false
    end
   
    def hours_spent
        running_time + time_spent
    end

    def time_spent_to_s
        total = hours_spent
        hours = total.to_i
        minutes = ((total - hours) * 60).to_i
        hours.to_s + l(:time_logger_hour_sym) + minutes.to_s.rjust(2, '0')
    end

    def zombie?
        zombie = false
        user = help.user_from_id(self.user_id)
        if user.nil? or user.locked?
            zombie =  true
        end

        issue = help.issue_from_id(self.issue_id)
        if issue.nil? or !user.allowed_to?(:log_time, issue.project)
            zombie = true
        end

    end

    protected

    def running_time
        if paused
            running_time = 0
        else
            running_time = ((Time.now.to_i - started_on.to_i) / 3600.0).to_f
        end
    end
end
