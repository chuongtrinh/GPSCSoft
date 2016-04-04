class ModifyDepartmentModel < ActiveRecord::Migration
  def change
    
    remove_column :departments, :name
    remove_column :departments, :department_id
    add_column :departments, :academic_unit_name, :string, index: true
    add_column :departments, :college, :string
    
  end
end
