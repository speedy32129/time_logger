class CreateTimeLoggers < ActiveRecord::Migration
  def self.up
    create_table :time_loggers do |t|
      t.column :user_id, :integer
      t.column :issue_id, :integer
      t.column :started_on, :datetime
      t.column :time_spent, :float, :default => 0
      t.column :paused, :boolean, :default => false
    end
  end

  def self.down
    drop_table :time_loggers
  end
end
