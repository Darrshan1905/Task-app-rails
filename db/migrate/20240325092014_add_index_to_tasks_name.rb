class AddIndexToTasksName < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:name, :project_id], unique: true
  end
end
