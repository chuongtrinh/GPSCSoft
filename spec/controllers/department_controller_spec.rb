require 'rails_helper'

RSpec.describe DepartmentController, type: :controller do
    
    before do
            @d=Department.new
            @d.academic_unit_name="Evil academic unit 101"
            @d.college="Evil College"
            @d.previous_state="1"
            @d.current_state="2"
            @d.save!
    end
    it "update_department when department exists" do
        expect(DepartmentController.update_department Hash["academic_unit_name","Evil academic unit 101"]).not_to be("saved!")
    end
    
    it "update_department when department is new" do
        DepartmentController.update_department Hash["academic_unit_name","Good academic unit 101",
                                                    "college","Good college"]
        @department = Department.find_by_academic_unit_name "Good academic unit 101"                                            
        expect(@department.academic_unit_name).to eq("Good academic unit 101")
        expect(@department.college).to eq("Good college")
        expect(@department.previous_state).to eq("1")
        expect(@department.current_state).to eq("1")
    end

end
