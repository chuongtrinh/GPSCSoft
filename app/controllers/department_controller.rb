class DepartmentController < ApplicationController
    
    
    def self.update_department row
      
      @department = Department.find_by_academic_unit_name(row["academic_unit_name"]);
      if @department
        
      else
        @department=Department.new
        @department.academic_unit_name = row["academic_unit_name"]
        @department.college = row["college"]
        @department.previous_state ='1';
        @department.current_state ='1';
        @department.save!
      end
      
    end
end
