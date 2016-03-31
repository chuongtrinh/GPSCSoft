require "spec_helper"
describe Representative do
    it "is named pancho" do
        representative = Representative.new
        representative.name = "pancho"
        expect(representative.name).to eq("pancho")
    end
    
    it "is assigned to uin 123" do
        representative = Representative.new
        representative.uin = "123"
        expect(representative.uin).to eq("123")
    end
    
    it "is saved to database" do
        def save_representative(representative)
            "saved!" if representative.save
        end
        @representative = Representative.new(:name => "pancho", :uin => "123")
        @representative.save!
        expect(save_representative(@representative)).to eq("saved!")
    end
    
end