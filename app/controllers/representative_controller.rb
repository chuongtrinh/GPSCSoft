class RepresentativeController < ApplicationController
    
    def self.update_representative row
        instance = Representative.find_by_first_name(row["first_name"]) && Representative.find_by_last_name(row["last_name"]) || Representative.new
        instance.attributes = row.to_hash.slice(*Representative.attribute_names())
        instance.save!
    end
    
end