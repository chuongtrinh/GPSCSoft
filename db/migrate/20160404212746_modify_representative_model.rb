class ModifyRepresentativeModel < ActiveRecord::Migration
  def change
    
    remove_column :representatives, :name
    add_column :representatives, :last_name, :string
    add_column :representatives, :first_name, :string
    add_column :representatives, :email, :string
    add_reference :representatives,:department, foreign_key: true

  end
end
