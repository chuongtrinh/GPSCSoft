class RepresentativeController < ApplicationController
    
    def self.update_representative row
        @department=Department.find_by_academic_unit_name(row["academic_unit_name"]);
        instance = Representative.find_by(first_name: row["first_name"],last_name: row["last_name"])|| @department.representatives.new
        instance.attributes = row.to_hash.slice(*Representative.attribute_names())
        instance.save!
        
    end
    
    def self.find_by_name(name)
        first_name=name.split(' ')[0]
        last_name=name.split(' ')[-1]
        # temp = Representative.find_by(first_name: first_name.to_s,last_name: last_name.to_s)
        # puts "#{first_name} #{last_name} bbb" 
        return Representative.find_by(first_name: first_name.to_s,last_name: last_name.to_s)

    end
    
    def update_all_attending_representatives(spreadsheet, all_department_states, name_notfound)
      (2..spreadsheet.last_row).each do |i| 
         row  = spreadsheet.row(i)
         # all representatives here should be considered as attendance
         @representative = RepresentativeController.find_by_name(row[0])

         if @representative.nil? 
            name_notfound.push(row[0])
         else
            all_department_states[@representative.department_id] = 1
         end
      end
    end
end