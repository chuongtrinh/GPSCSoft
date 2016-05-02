require 'rails_helper'

RSpec.describe SheetsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index, {:sorting => {:attachment =>"academic_unit_name"}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      get :index, {:sorting => {:attachment =>"college"}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success" do
      get :index, {:sorting => {:attachment =>"eligibility"}}
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
        @file3 = fixture_file_upload('files/Book1.xlsx', 'text/xlsx')
        @file4 = fixture_file_upload('files/Attendance Swipe Data empty.xls', 'text/xls')
        @file5 = fixture_file_upload('files/Iteration0.docx', 'text/docx')
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
    it "returns http success with other name" do
      get :create, {:sheet => {:attachment =>@file3}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success with empty file" do
      get :create, {:sheet => {:attachment =>@file4}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success with wrong filetype" do
      get :create, {:sheet => {:attachment =>@file5}}
      expect(response).to have_http_status(:success)
    end
    it "returns http success with no file" do
      get :create
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
  
  describe "open_spreadsheet" do
    before do
      @file = fixture_file_upload('files/Attendance Swipe Data1.xls', 'text/xls')
      @file1 = fixture_file_upload('files/2015-2016 GPSC Attendance.xlsx', 'text/xlsx')
      @file2 = fixture_file_upload('files/Attendance Swipe Data (2016-02-16).csv', 'text/csv')
      @controller=SheetsController.new
    end
    it "open xsl" do
      spreadsheet=@controller.open_spreadsheet(@file)
      expect(spreadsheet).not_to be(nil)
      expect(spreadsheet).not_to be(false)
    end
    it "open xslx" do
      spreadsheet=@controller.open_spreadsheet(@file1)
      expect(spreadsheet).not_to be(nil)
      expect(spreadsheet).not_to be(false)
    end
    it "open csv" do
      spreadsheet=@controller.open_spreadsheet(@file2)
      expect(spreadsheet).not_to be(nil)
      expect(spreadsheet).not_to be(false)
    end
  end
  
  describe "validate_attendance_sheet" do
    before do
      @file = fixture_file_upload('files/Attendance Swipe Data (2016-02-16).csv', 'text/csv')
      @controller=SheetsController.new
    end
    it "validate format of attendance sheet" do
      spreadsheet = @controller.open_spreadsheet(@file)
      validation_value=@controller.validate_attendance_sheet(spreadsheet)
      expect(validation_value).to be(true)
    end
  end
  
end
