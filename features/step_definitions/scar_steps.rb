Given /^the API pages have been generated by Yard version 0\.5$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the API pages are compiled$/ do
  steps %Q{
    Given this project is active project folder
    Given "website" folder does exist
    When I invoke task "rake site:rebuild"
    Then task "rake site:rebuild" is executed successfully
    }
end
Given /^the nanoc3 auto\-compiler web\-server is running$/ do
  in_project_folder do
    FileUtils.chdir('./website') do
      cmd = 'nanoc3 aco --server=thin --port=3000 --host=localhost'
      res = Kernel.system("#{cmd} &>/tmp/nanoc-aco.log &")
      raise RuntimeError.new("Failed to start nanoc3 auto\-compiler web\-server (Thin)") unless res
    end
  end
end

Given /^the API pages are published$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^\"]*)" table$/ do |arg1, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end
