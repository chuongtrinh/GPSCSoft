class SheetsController < ApplicationController
   def index
      @sheets = Sheet.all
      @representatives=Representative.all
   end
   
   def new
      @sheet = Sheet.new
   end
   
   def create
      @sheet = Sheet.new(sheet_params)
      
      if params[:sheet][:attachment]
         if @sheet.save
            Representative.uploadFile(params[:sheet][:attachment])
            redirect_to sheets_path, notice: "The sheet #{@sheet.name} has been uploaded."
         else
            render "new"
         end
      else
         flash[:notice] = "#{@sheet.name} was created unsuccessfully (Missing upload file)"
         render "new"
      end    
       
   end
   
   def destroy
      @sheet = Sheet.find(params[:id])
      @sheet.destroy
      redirect_to sheets_path, notice:  "The sheet #{@sheet.name} has been deleted."
   end
   
   private
      def sheet_params
         params.require(:sheet).permit(:name, :attachment)
      end
end
