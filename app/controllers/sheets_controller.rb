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
               if @sheet.save
                  if uploadFile(params[:sheet][:attachment])
                     redirect_to sheets_path, notice: "The sheet has been uploaded."
                  else
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
            else raise "Unknown file type: #{file.original_filename}"
      end
   end
    
   def uploadFile(file)
         spreadsheet = SheetsController.open_spreadsheet(file)
         if is_empty spreadsheet
            return nil
         end
         header = spreadsheet.row(1)
         arranged_header=arrange_representative_header header
         
         (2..spreadsheet.last_row).each do |i|
           row = Hash[[arranged_header, spreadsheet.row(i)].transpose]
           puts row
           DepartmentController.update_department row
           RepresentativeController.update_representative row
         end
   end 


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
