class Delete < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :task_deadline, true
  end
end
