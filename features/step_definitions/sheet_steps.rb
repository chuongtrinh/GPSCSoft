 
Then /^I upload a Registration file$/ do
  attach_file('sheet[attachment]', File.join('features/Upload'))
  click_button "Save"
end



Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("\"#{filename}\"")
end



When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept    
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end


Given /^a confirmation box saying "([^\"]*)" should pop up$/ do |message|
  @expected_message = message
end


Then /^I should receive a (.*) file$/ do |file_type|
  file_type = case file_type
  when 'CSV'
    'text/csv'
  else
    file_type
  end

 # assert_match /^attachment;/, page.response_headers['Content-Disposition'], "The response was not an attachment."
#  assert_match /^#{file_type}(?:$|;)/, page.response_headers['Content-Type']
end


Then /^I should receive a file(?: "([^"]*)")?/ do |file|
  result = page.response_headers['Content-Type'].should == "CSV"
  if result
    result = page.response_headers['Content-Disposition'].should =~ /#{file}/
  end
  result
end


Then /^it should output "([^"]*)" in "([^"]*)"$/ do |string, color|
  assert_partial_output(string.color(color.to_sym), all_output)
end

Then /"(.*)" should appear before "(.*)"/ do |first_example, second_example|
     page.should =~ /#{first_example}.*#{second_example}/
   end