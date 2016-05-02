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
            @d.meeting_attendance = "1"
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
        expect(@department.meeting_attendance).to eq("1")
    end

    describe "initialize states" do
        it "initialize all states" do
            @all_department_states=DepartmentController.initialize_states
            expect(@all_department_states).not_to be(nil)
        end
    end
    
    
    describe "GET #reset" do
        it "returns http success" do
          get :reset
          expect(response).to have_http_status(:found)
        end
    end
    
    describe "update_all_department_states" do
    
        before do
            @d=Department.new
            @d.academic_unit_name="Evil academic unit 102"
            @d.college="Evil College"
            @d.previous_state="1"
            @d.current_state="2"
            @d.meeting_attendance = "1"
            @d.save!
        end
        
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @id = @department.id
            @Hash = {@id => 1}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("1")
        end
        
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @id = @department.id
            @Hash = {@id => 0}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("3")
        end
        
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @department.current_state = "1"
            @department.save!
            @id = @department.id
            @Hash = {@id => 0}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("2")
        end
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @department.current_state = "3"
            @department.save!
            @id = @department.id
            @Hash = {@id => 1}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("4")
        end
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @department.current_state = "4"
            @department.save!
            @id = @department.id
            @Hash = {@id => 1}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("1")
        end
        it "update all departments eligibility" do
            @department = Department.find_by_academic_unit_name "Evil academic unit 102" 
            @department.current_state = "4"
            @department.save!
            @id = @department.id
            @Hash = {@id => 0}
            DepartmentController.update_all_department_states(@Hash)
            @d = Department.find_by_academic_unit_name "Evil academic unit 102"
            expect(@d.current_state).to eq("3")
        end
    end
            
end
