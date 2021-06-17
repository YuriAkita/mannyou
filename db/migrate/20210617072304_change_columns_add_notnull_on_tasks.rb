class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :task_deadline, false, default: 0
  end
end
