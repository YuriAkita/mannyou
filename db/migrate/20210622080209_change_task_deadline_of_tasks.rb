class ChangeTaskDeadlineOfTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :task_deadline, :datetime, default:-> { 'CURRENT_TIMESTAMP' }
  end
end
