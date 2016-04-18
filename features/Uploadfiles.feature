Feature: User can manually upload spreadsheet
 
Scenario: Upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Book1.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  
  
Scenario: Fail to upload a spreadsheet
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
  Then I should see "Attachment You"
  
Scenario: Upload an empty file
  Given I am on the GPSC home page
  When I follow "New Sheet"
  Then I attach the file "features/Book2.xlsx" to "sheet_attachment"
  When I press "Save"
  Then I should see "was created unsuccessfully (The file you uploaded is empty)"