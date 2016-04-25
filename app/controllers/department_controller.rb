class DepartmentController < ApplicationController
    
    def reset
      @departments=Department.all
      @departments.each do |department|
        department.destroy
      end
      redirect_to sheets_path
    end
    
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
  
    def self.initialize_states
      all_department_states = {}
      # initialize all states 
      Department.all.each do |entry|
         all_department_states[entry.id] = 0
      end
      return all_department_states
    end
  
    def self.update_all_department_states(all_department_states)
        all_department_states.each do |key,state_val|
         @department = Department.find_by_id(key);
         @department.previous_state = @department.current_state
         case @department.current_state
            when '1'
               if state_val == 0
                  @department.current_state = '2'
               end
            when '2'
               if state_val == 1
                  @department.current_state = '1'
               else
                  @department.current_state = '3'
               end
            when '3'
               if state_val == 1
                  @department.current_state = '4'
               end
            when '4'
               if state_val == 1
                  @department.current_state = '1'
               else
                  @department.current_state = '3'
               end
         end
         @department.save!
      end
      return all_department_states
    end
   
end
