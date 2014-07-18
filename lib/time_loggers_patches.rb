# use require_dependency if you plan to utilize development mode
require 'application_helper'

module TimeLoggers
  module Patches
    module ApplicationHelperPatch
      def self.included(base) # :nodoc:
        # sending instance methods to module
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable

          # aliasing methods if needed
          # alias_method_chain :render_page_hierarchy, :watchers
        end
      end

      # Instance methods are here
      module InstanceMethods

	    def time_logger_for(user)
		TimeLogger.find(:first, :conditions => { :user_id => user.id })
	    end

	    def status_from_id(status_id)
		IssueStatus.find(:first, :conditions => { :id => status_id })
	    end

	    def statuses_list()
		IssueStatus.find(:all)
	    end

	    def to_status_options(statuses)
		options_from_collection_for_select(statuses, 'id', 'name')
	    end

	    def new_transition_from_options(transitions)
		statuses = []
		for status in statuses_list()
		    if !transitions.has_key?(status.id.to_s)
			statuses << status
		    end
		end
		to_status_options(statuses)
	    end

	    def new_transition_to_options()
		to_status_options(statuses_list())
	    end

	    def global_allowed_to?(user, action)
		return false if user.nil?

		projects = Project.find(:all)
		for p in projects
		    if user.allowed_to?(action, p)
			return true
		    end
		end

		return false
	    end
      
      end
    end
  end
end

# now we should include this module in ApplicationHelper module
unless ApplicationHelper.included_modules.include? TimeLoggers::Patches::ApplicationHelperPatch
    ApplicationHelper.send(:include, TimeLoggers::Patches::ApplicationHelperPatch)
end