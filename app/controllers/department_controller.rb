class DepartmentController < ApplicationController
    
    
    def self.update_department row
      
      
      if Department.find_by_academic_unit_name(row["academic_unit_name"])
      else
        @d=Department.new
        @d.academic_unit_name=row["academic_unit_name"]
        @d.college=row["college"]
        @d.state=5
        @d.save!
      end
      
    end
end
