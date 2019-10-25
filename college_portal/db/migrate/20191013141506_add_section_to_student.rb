class AddSectionToStudent < ActiveRecord::Migration[5.2]
  def change
     add_column :students, :section_id, :integer
  end
end
