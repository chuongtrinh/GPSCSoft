 
Then /^I upload a Registration file$/ do
  attach_file('sheet[attachment]', File.join('features/Upload'))
  click_button "Save"
end



Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("/uploads/sheet/attachment/1/Book1.xlsx")
end