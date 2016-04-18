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
    
end