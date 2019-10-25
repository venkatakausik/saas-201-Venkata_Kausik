class AddDepartmentToSection < ActiveRecord::Migration[5.2]
  def change
     add_column :sections, :department_id, :integer
  end
end
