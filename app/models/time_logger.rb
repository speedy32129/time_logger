class TimeLogger < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue

  def initialize(arguments = nil)
    super(arguments)
    self.user_id = User.current.id
    self.started_on = DateTime.current
    self.time_spent = 0
    self.paused = false
  end

  def seconds_spent
    running_time + time_spent.to_i
  end

  def hours_spent
    (seconds_spent.to_f / 3600.0).round(2)
  end

  def time_spent_to_s
    total = seconds_spent
    "%02d:%02d:%02d" % [total / 3600, total / 60%60, total % 60]
  end

  def total_time
    total = seconds_spent
    hours = total / 3600
    minutes = total / 60%60
    seconds = total % 60

    {
        :total => "%02d:%02d:%02d" % [total / 3600, total / 60%60, total % 60],
        :hours => hours,
        :minutes => minutes,
        :seconds => seconds
    }
  end

  def zombie?
    return true unless user
    return true unless issue
    return true if user.locked?
    return true unless user.allowed_to?(:log_time, issue.project)

    false
  end

  def running_time
    if paused?
      0
    else
      Time.current.to_i - started_on.to_i
    end
  end
end
