class SheetsController < ApplicationController
   def index
      
  	#  @d1={:academic_unit_name => 'Performance Studies', :college => 'Liberal Arts', :state => '1'}
   #  Department.create!(@d1)


      @sheets = Sheet.all
      @representatives=Representative.all
      @departments=Department.all


   end
   
   def new
      @sheet = Sheet.new
   end
   
   def create
         if params.has_key?(:sheet)
            @sheet = Sheet.new(sheet_params)
            @sheet.name = params[:sheet][:attachment].original_filename
               if @sheet.save
                  if uploadFile(params[:sheet][:attachment])
                     # redirect_to sheets_path, notice: "The sheet has been uploaded."
                  else
                     @sheet.destroy
                     flash[:notice] = "The sheet was created unsuccessfully (The file you uploaded is empty)"
                     render "new"
                  end
               else
                  render "new"
               end
         else
            @sheet = Sheet.new
            flash[:notice] = "The sheet was created unsuccessfully (Missing upload file)"
            print params
            render "new"
         end
   end
   
   def destroy
      @sheet = Sheet.find(params[:id])
      @sheet.destroy
      redirect_to sheets_path, notice:  "The sheet #{@sheet.name} has been deleted."
   end
   
   def self.open_spreadsheet(file)
      case File.extname(file.original_filename)
         when ".xls" then Roo::Excel.new(file.path)
            when ".xlsx" then Roo::Excelx.new(file.path)
               when ".csv" then Roo::CSV.new(file.path)
            else raise "Unknown file type: #{file.original_filename}"
      end
   end

   def identify_spreadsheet_type(file)
      if file.original_filename =~ /^Attendance Swipe Data.\S+$/
         return '1'
      elsif file.original_filename =~ /^\S+ GPSC Attendance.\S+$/
         return '2'
      else
         return '3'
      end
   end
   
   def uploadFile(file)
         spreadsheet = SheetsController.open_spreadsheet(file)
         if is_empty spreadsheet
            return nil
         end

         header = spreadsheet.row(1)
         arranged_header=arrange_representative_header header
         
         filetype = identify_spreadsheet_type(file)
         case filetype
            # file type is attendance or card swipe
            when '1'
                    
            # This should be called after determining the type of sheet file 
            # This should belong to attendance sheet
            
            if (!validate_attendance_sheet(2..spreadsheet.last_row))
               redirect_to sheets_path, notice: "One or more entries' names in swipe card sheet are missing"
            end
         
         
            all_department_states = {}
            # initialize all states 
            Department.all.each do |entry|
               all_department_states[entry.id] = 0
            end
         
            # update the states in temporary states table
            (2..spreadsheet.last_row).each do |i| 
              
               update_states_table(spreadsheet.row(i),all_department_states)
            end
          
            # update the Department model
            update_state(all_department_states)
            # redirect_to sheets_path, notice: "The attendance sheet has been uploaded."
            
            # filetype is registration
            when '2' 
         
            (2..spreadsheet.last_row).each do |i|
               row = Hash[[arranged_header, spreadsheet.row(i)].transpose]
           
           
            # This is 
            DepartmentController.update_department row
           
            RepresentativeController.update_representative row
            
            end 
            redirect_to sheets_path, notice: "The registration sheet has been uploaded."
            # Invalid file type
            when '3'
            flash[:notice] = "The name of the spreadsheet uploaded does not match the system default (Include 'GPSC Attendance' for registration update or 'Attendance Swipe Data' for attendance update)"
            render "new"
         end
         
   end
   def validate_attendance_sheet(rows)
      # perform checking error 
      # 1. if missing name
      rows.each do |row|
         if row[0].nil? || row[0].blank?
            return false
         end
      end
      return true
   end
   def update_states_table(row, all_department_states)
      
      # all representatives here should be considered as attendance
      @representative = RepresentativeController.find_by_name(row[0])
      #@department = Department.find_by_id(@representative.department_id);
      
      # update states for attending department
      # puts "#{@representative.first_name}  dsds"
      if @representative.nil? 
         flash[:notice] = "#{row[0]} is not in the registration sheet"
      else
         all_department_states[@representative.department_id] = 1
      end
   end
   def update_state(all_department_states)
      
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
   end


      # storing the previous state so we can back it 
      #@department.previous_state = @department.current_state 
   


   private
   def sheet_params
      params.require(:sheet).permit(:attachment)
   end
   
   #getting an array with the titles used on data base for representative
   def arrange_representative_header header
      head={"FIRST NAME" => "first_name",
               "LAST NAME"  => "last_name",
               "EMAIL"      => "email",
               "UIN"        => "uin",
               "FULL ACADEMIC UNIT NAME"        => "academic_unit_name",
               "COLLEGE"        => "college"
            }
      arranged_header=[]
         header.each do |k|
              arranged_header.push head[k]
         end
      return arranged_header
   end
   
   def is_empty spreadsheet
      return !spreadsheet.first_row
   end
   
end
