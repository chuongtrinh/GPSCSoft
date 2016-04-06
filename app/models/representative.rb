class Representative < ActiveRecord::Base
    belongs_to :department
    
    def self.uploadFile(file)
         model = Representative
          spreadsheet = SheetsController.open_spreadsheet(file)
          header = spreadsheet.row(1)
          
          (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            instance = find_by_id(row["id"]) || new
            instance.attributes = row.to_hash.slice(*model.attribute_names())
            instance.save!
          end
    end

end