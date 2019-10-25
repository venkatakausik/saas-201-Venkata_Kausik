class AddDepartmentToStudent < ActiveRecord::Migration[5.2]
  def change
     add_column :students, :department_id, :integer
  end
end
