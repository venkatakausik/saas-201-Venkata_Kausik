class ChangeRollNoToBeStringInStudents < ActiveRecord::Migration[5.2]
  def change
       change_column :students, :roll_no, :string
  end
end
