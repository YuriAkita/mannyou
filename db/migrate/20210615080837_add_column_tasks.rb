class AddColumnTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :task_deadline, :date
  end
end
