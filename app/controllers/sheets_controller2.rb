class SheetsController < ApplicationController
   def index
      @sheets = Sheet.all
      @representatives=Representative.all
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
   #------------------------------------------------i'm working here------------------
   def uploadFile(file)
         head={"FIRST NAME" => "first_name",
               "LAST NAME"  => "last_name",
               "EMAIL"      => "email",
               "UIN"        => "uin"}
         spreadsheet = SheetsController.open_spreadsheet(file)
         if !spreadsheet.first_row
            return nil
         end
         header = spreadsheet.row(1)
         arranged_header=[]
         #getting an array with the titles used on data base
         header.each do |k|
              arranged_header.push head[k]
         end
         
         (2..spreadsheet.last_row).each do |i|
           row = Hash[[arranged_header, spreadsheet.row(i)].transpose]
           instance = Representative.find_by_first_name(row["first_name"]) && Representative.find_by_last_name(row["last_name"]) || Representative.new
           instance.attributes = row.to_hash.slice(*Representative.attribute_names())
           instance.save!
         end
    end 
   #----------------------------------------------------------------------------------
   
   private
   def sheet_params
      params.require(:sheet).permit(:attachment)
   end
end
