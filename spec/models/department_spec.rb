require "spec_helper"
describe Department do
    it "college is science" do
        department = Department.new
        department.college = "science"
        expect(department.college).to eq("science")
    end
    
    it "academic_unit_name is biology" do
        department = Department.new
        department.academic_unit_name = "biology"
        expect(department.academic_unit_name).to eq("biology")
    end
    
    it "is assigned to state 1" do
        department = Department.new
        department.previous_state = "1"
        department.current_state = "2"
        expect(department.previous_state).to eq("1")
        expect(department.current_state).to eq("2")
    end
    
    it "is saved to database" do
        def save_department(department)
            "saved!" if department.save
        end
        @department = Department.new(:college => "science", :previous_state => "1", :current_state => "2", :academic_unit_name => "biology")
        @department.save!
        expect(save_department(@department)).to eq("saved!")
    end
    
end