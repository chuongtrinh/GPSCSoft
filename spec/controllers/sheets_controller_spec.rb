require 'rails_helper'

RSpec.describe SheetsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    before do
        @file = fixture_file_upload('files/2015-2016 GPSC Attendance.xlsx', 'text/xlsx')
        @file1 = fixture_file_upload('files/Attendance Swipe Data (2016-02-16).csv', 'text/csv')
        @file2 = fixture_file_upload('files/Attendance Swipe Data (2016-02-02).xls', 'text/xls')
      end
    it "returns http success with xlsx" do
      get :create, {:sheet => {:attachment =>@file}}
      expect(response).to have_http_status(:found)
    end
    it "returns http success with csv" do
      get :create, {:sheet => {:attachment =>@file1}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success with xls" do
      get :create, {:sheet => {:attachment =>@file2}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "identify_spreadsheet_type" do
    before do
      @file = fixture_file_upload('files/2015-2016 GPSC Attendance.xlsx', 'text/xlsx')
      @file1 = fixture_file_upload('files/Attendance Swipe Data.xlsx', 'text/xlsx')
      @file2 = fixture_file_upload('files/evil file.xlsx', 'text/xlsx')
      @controller=SheetsController.new
    end
    it "identifies registration file upload" do
      @value=@controller.identify_spreadsheet_type(@file)
      expect(@value).to eq('2')
    end

    it "identifies attendance file upload" do
      @value=@controller.identify_spreadsheet_type(@file1)
      expect(@value).to eq('1')
    end
    
    it "identifies random files upload" do
      @value=@controller.identify_spreadsheet_type(@file2)
      expect(@value).to eq('3')
    end
  end
  
end
