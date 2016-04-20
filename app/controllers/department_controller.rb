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
    def self.downloadcsv
      state_to_eligibility={'1'=>"yes",'2'=>"yes",'3'=>"no",'4'=>"no"}
      CSV.generate do |csv|
      csv << ["academic_unit_name","eliglibility" ]
      departments=Department.all
      departments.each do |department|
      csv << [department.academic_unit_name,state_to_eligibility[department.current_state]]
    end
    end
 
    end
    
end
