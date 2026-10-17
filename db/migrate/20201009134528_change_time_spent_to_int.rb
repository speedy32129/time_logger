class ChangeTimeSpentToInt < ActiveRecord::Migration[5.2]
  def change
    # Conversion from base type FLOAT to INTEGER is not supported.
    reversible do |dir|
        dir.up {
          remove_column(:time_loggers, :time_spent, :float)
          add_column(:time_loggers, :time_spent, :integer, :default => 0)
        }
        dir.down {
          remove_column(:time_loggers, :time_spent, :integer)
          add_column(:time_loggers, :time_spent, :float, :default => 0.0)
        }
    end
  end
end
