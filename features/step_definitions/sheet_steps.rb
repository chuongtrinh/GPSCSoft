 
Then /^I upload a Registration file$/ do
  attach_file('sheet[attachment]', File.join('features/Upload'))
  click_button "Save"
end

