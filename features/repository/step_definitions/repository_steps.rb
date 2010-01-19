require 'extlib'
dir = Pathname(__FILE__).dirname.expand_path / '..' / '..'
require dir / 'support' / 'env'

Given /^the Sun Cloud API pages on Kenai are not versioned$/ do
  @versioned_api = false
end

Given /^the entry point is for API version ([^\"]*)$/ do |ver|
  ver =~ /nil/ ? @versioned_api = false : @versioned_api = true
end

Given /^the "([^\"]*)" file does not exist in the repository$/ do |file_name|
  @repository_path = "./spec/factories/sca"
  @api_file_name = file_name
  steps %Q{And "#{@repository_path}" folder does exist
     And "#{@repository_path}/#{file_name}" file does not exist}
end

When /^I scrape the API page "([^\"]*)"$/ do |link_text|
  puts "#{@file_not_exists.to_s} #{link_text}"
  if @file_not_exists
    puts "We should not see this..."
    response = visit(path_to(link_text))
    response.save_as(File.join(@repository_path, @api_file_name)) 
  end
end

When /^I scrape "([^\"]*)" to folder "([^\"]*)"$/ do |page_name, folder|
  pending
end

Then /^I should see "([^\"]*)" in "([^\"]*)"$/ do |file_name, folder|
  pending
end

Then /^I should see the API file in the repository$/ do 
  File.exists?(File.join(@repository_path, @api_file_name )).should be_true
end
