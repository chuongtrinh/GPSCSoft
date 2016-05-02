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
    
    it "creates new representative when it doesn't exist" do
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
    
    before do
            @r=Representative.new
            @r.first_name="paco"
            @r.last_name="torrado"
            @r.email="puf@puf.com"
            @r.uin="321"
            @r.save!
    end

    it "update representative when it exist" do
        RepresentativeController.update_representative Hash["first_name","paco",
                                                            "last_name","torrado",
                                                            "email","splash@splash.com",
                                                            "academic_unit_name","Evil academic unit 101"]
        @representative = Representative.find_by_first_name "paco"                                            
        expect(@representative.first_name).to eq("paco")
        expect(@representative.last_name).to eq("torrado")
        expect(@representative.email).to eq("splash@splash.com")
        expect(@representative.uin).to eq("321")
    end
    
    before do
        @r=Representative.new
        @r.first_name="juan"
        @r.last_name="perez"
        @r.uin="333"
        @r.save!
        
    end
    
    it "find representatives by name" do
        @representative=RepresentativeController.find_by_name "juan perez"
        expect(@representative.first_name).to eq("juan")
        expect(@representative.last_name).to eq("perez")
        expect(@representative.uin).to eq("333")
    end
    
    before do
        @file = fixture_file_upload('files/Attendance Swipe Data1.xls', 'text/xls')
        @file1 = fixture_file_upload('files/Attendance Swipe Data2.xls', 'text/xls')
        
        def open_spreadsheet(file)
            case File.extname(file.original_filename)
             when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
             when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
             when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
             else 
                return false
            end
        end
    end
    
    it "update_all_attending_representatives adds not found names" do
        spreadsheet = open_spreadsheet(@file1)
        all_department_states = DepartmentController.initialize_states
        list_of_not_found_name = []
        RepresentativeController.update_all_attending_representatives(spreadsheet, all_department_states, list_of_not_found_name)
        expect(list_of_not_found_name.length).to be >= 1
    end

    
    
    before do
        @d=Department.new
        @d.academic_unit_name="Evil academic unit 101"
        @d.college="Evil College"
        @d.previous_state="1"
        @d.current_state="2"
        @d.save!
        
        @r=@d.representatives.new
        @r.first_name="Robert"
        @r.last_name="Rogers"
        @r.uin="523005938"
        @r.save!
    end
    
    it "update_all_attending_representatives modify state of attending users" do
        spreadsheet = open_spreadsheet(@file)
        all_department_states = DepartmentController.initialize_states
        list_of_not_found_name = []
        RepresentativeController.update_all_attending_representatives(spreadsheet, all_department_states, list_of_not_found_name)
        @representative=Representative.find_by_first_name("Robert")
        expect(all_department_states[@representative.department_id]).to eq(1)
    end
    
end