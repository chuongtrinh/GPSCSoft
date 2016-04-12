class RepresentativeController < ApplicationController
    
    def self.update_representative row
        instance = Representative.find_by(first_name: row["first_name"],last_name: row["last_name"])|| Representative.new
        instance.attributes = row.to_hash.slice(*Representative.attribute_names())
        instance.save!
    end
    
end