require 'rails_helper'

RSpec.describe RepresentativeController, type: :controller do
    
    before do
            @d=Department.new
            @d.academic_unit_name="Evil academic unit 101"
            @d.college="Evil College"
            @d.previous_state="1"
            @d.current_state="2"
            @d.save!
    end

    it "update representative when it exist" do
        RepresentativeController.update_representative Hash["first_name","juan",
                                                            "last_name","perez",
                                                            "email","blarg@blarg.com",
                                                            "uin","123",
                                                            "academic_unit_name","Evil academic unit 101"]
        @representative = Representative.find_by_first_name "juan"                                            
        expect(@representative.first_name).to eq("juan")
        expect(@representative.last_name).to eq("perez")
        expect(@representative.email).to eq("blarg@blarg.com")
        expect(@representative.uin).to eq("123")
    end

end