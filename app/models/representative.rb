class Representative < ActiveRecord::Base
    belongs_to :department
    
     def self.uploadFile(file)
    allowed_attributes = [ :uin,:name]
 
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    department = find_by_id(row["id"]) || new
   department.attributes = row.to_hash.slice(*Representative.attribute_names())
    department.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
 when ".xls" then Roo::Excel.new(file.path)
  when ".xlsx" then Roo::Excelx.new(file.path)
 else raise "Unknown file type: #{file.original_filename}"
end
end
end
