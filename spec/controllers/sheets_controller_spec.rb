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

        def SheetsController.open_spreadsheet(file)
          return Roo::Excelx.new(file.path, file_warning: :ignore)
        end
      end
    it "returns http success" do
      get :create, {:sheet => {:attachment =>@file}}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end
end
