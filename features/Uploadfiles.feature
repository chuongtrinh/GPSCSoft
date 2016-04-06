Feature: User can manually upload spreadsheet
 
Scenario: Upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  And I fill in "Name" with "sheet1"
  Then I attach the file "features/Book1.xlsx" to "Attachment"
  When I press "Save"
  Then I should be on the GPSC home page
  
  
Scenario: Fail to upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  And I fill in "Name" with "sheet1"
 #Then I attach the file "features/Upload/Book1.doc" to "Attachment"
  When I press "Save"
  Then I should see "sheet1 was created unsuccessfully (Missing upload file)"
  
Scenario: Fail to upload a spreadsheet
  Given I am on the GPSC home page
  When I follow "New Sheet"
  And I fill in "Name" with "sheet1"
  Then I attach the file "features/Upload/Book1.doc" to "Attachment"
  When I press "Save"
  Then I should see "Attachment You"
  
Scenario: Upload an empty file
  Given I am on the GPSC home page
  When I follow "New Sheet"
  And I fill in "Name" with "sheet1"
  Then I attach the file "features/Book2.xlsx" to "Attachment"
  When I press "Save"
  Then I should see "was created unsuccessfully (The file you uploaded is empty)"