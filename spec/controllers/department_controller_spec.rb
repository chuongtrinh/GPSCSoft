require 'rails_helper'

RSpec.describe DepartmentController, type: :controller do
    it "update departments table with a new department" do
        DepartmentController.update_department Hash["academic_unit_name","Good academic unit 101",
                                                            "college","Good College"]
        @department=Department.find_by_academic_unit_name "Good academic unit 101"
        expect(@department.academic_unit_name).to eq("Good academic unit 101")
        expect(@department.college).to eq("Good College")
        expect(@department.previous_state).to eq("1")
        expect(@department.current_state).to eq("1")
    end
    
     before do
            @d=Department.new
            @d.academic_unit_name="Evil academic unit 101"
            @d.college="Evil College"
            @d.previous_state="1"
            @d.current_state="2"
            @d.save!
    end
    it "ignore update departments table with a existed department" do
        DepartmentController.update_department Hash["academic_unit_name","Evil academic unit 101",
                                                            "college","Not as Evil College"]
        @department=Department.find_by_academic_unit_name "Evil academic unit 101"
        expect(@department.academic_unit_name).to eq("Evil academic unit 101")
        expect(@department.college).to eq("Evil College")
        expect(@department.previous_state).to eq("1")
        expect(@department.current_state).to eq("2")
    end

     it "initialize states" do
        @all_department_states=DepartmentController.initialize_states
        expect(@all_department_states).not_to be(nil)
    end
end
