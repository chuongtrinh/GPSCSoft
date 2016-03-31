require 'rails_helper'
describe Sheet do
    it "is named sheet" do
        sheet = Sheet.new
        sheet.name = "sheet"
        expect(sheet.name).to eq("sheet")
    end
end