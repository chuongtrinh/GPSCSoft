Feature: User can manually upload spreadsheet
 
Scenario: Upload a Registration sheet
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  Then I press "Save"
  Then I should see "The registration sheet has been uploaded."

Scenario: Upload a Attendance sheet
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  Then I press "Save"
  Then I should see "The registration sheet has been uploaded."
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "public/uploads/sheet/attachment/Attendance Swipe Data.csv" to "sheet_attachment"
  When I press "Save"
  Then I should see "The attendance sheet has been uploaded."
  
Scenario: Upload a file with wrong name
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Book1.xlsx" to "sheet_attachment"
  Then I press "Save"
  Then I should see "The name of the spreadsheet uploaded does not match the system default (Include 'GPSC Attendance' for registration update or 'Attendance Swipe Data' for attendance update)"
  
Scenario: didn't attach a file
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  When I press "Save"
  Then I should see "The sheet was created unsuccessfully (Missing upload file)"
  
Scenario: Upload a spreadsheet with wrong type
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Upload/Book1.doc" to "sheet_attachment"
  When I press "Save"
  Then I should see "The sheet was created unsuccessfully"
  
Scenario: Upload an empty file
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "public/uploads/sheet/attachment/1/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should see "was created unsuccessfully (The file you uploaded has wrong type or is empty)"
  
Scenario: Download a file
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  Then I follow "Download Eligibility Excel Sheet"
  Then I should receive a CSV file
 
Scenario: Names showing in attendance didn't show in registration
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Attendance Swipe Data .csv" to "sheet_attachment"
  When I press "Save"
  Then I should see "were not found in the representatives"
  
Scenario: User can reset the system
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Upload/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Upload/Attendance Swipe Data .csv" to "sheet_attachment"
  Then I press "Save"
  Given I am on the GPSC home page
  When I follow "Erase Everything"
  And a confirmation box saying "The action will remove all data in department and representative" should pop up
  Then I should be on the GPSC home page
  Then I should see "All departments and representatives are deleted"
  
Scenario: User download a Eligibility Sheet without uploading any file up front
  Given I am on the GPSC home page
  When I follow "Erase Everything"
  And a confirmation box saying "The action will remove all data in department and representative" should pop up
  Then I should be on the GPSC home page
  Then I should see "All departments and representatives are deleted"
  When I follow "Download Eligibility Excel Sheet"
  Then I should see "You need upload registration and attendance file before downloading"
  
Scenario: Click on instruction
  Given I am on the GPSC home page
  When I follow "Instructions on how to begin"
  Then I should see "The files must have correct names"
  When I follow "Instructions on how to download eligibility sheet"
  Then I should see "Download Eligibility Excel Sheet"
  When I follow "Instructions on when making mistakes"
  Then I should see "You can always go back from the beginning of semester"
  
Scenario: Sorting the columns
  Given I am on the GPSC home page
  When I follow "Upload Attendance or Registration Sheet"
  Then I attach the file "features/Upload/2015-2016 GPSC Attendance.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  When I follow "Academic Unit Name"
  #Then "Accounting" should appear before "Aerospace Engineering"
  Then I should see "Accounting"