require "spec_helper"
describe Department do
    it "is named software" do
        department = Department.new
        department.name = "pancho"
        expect(department.name).to eq("pancho")
    end
    
    it "is assigned to id 123" do
        department = Department.new
        department.department_id = "123"
        expect(department.department_id).to eq("123")
    end
    
    it "is assigned to state 1" do
        department = Department.new
        department.state = 1
        expect(department.state).to be(1)
    end
    
    it "is saved to database" do
        def save_department(department)
            "saved!" if department.save
        end
        @department = Department.new(:name => "pancho", :state => 1, :department_id => "123")
        @department.save!
        expect(save_department(@department)).to eq("saved!")
    end
    
end