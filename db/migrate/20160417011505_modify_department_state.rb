class ModifyDepartmentState < ActiveRecord::Migration
  def change
    
    
    remove_column :departments, :state
    add_column :departments, :current_state, :string
    add_column :departments, :previous_state, :string
    
  end
end
