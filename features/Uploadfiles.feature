Feature: User can manually upload spreadsheet
 
Scenario: Upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Book1.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  
  
Scenario: didn't attach a file
  Given I am on the GPSC home page
  When I follow "New Sheet"
 #Then I attach the file "features/Upload/Book1.doc" to "Attachment"
  When I press "Save"
  Then I should see "The sheet was created unsuccessfully (Missing upload file)"
  
Scenario: Fail to upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Upload/Book1.doc" to "sheet_attachment"
  When I press "Save"
  Then I should see "The sheet was created unsuccessfully"
  
Scenario: Upload an empty file
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Book2.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should see "was created unsuccessfully"
  
Scenario: Download a file
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  When I follow "Download CSV"
 # Then I should get a download with the filename "sheets.csv"
 
Scenario: Names showing in attendance didn't show in registration
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Attendance Swipe Data .csv" to "sheet_attachment"
  When I press "Save"
  Then I should see "were not found in the representatives"