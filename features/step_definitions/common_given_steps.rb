Given /^this project is active project folder/ do
  @active_project_folder = File.expand_path(File.dirname(__FILE__) + "/../..")
end

Given /^env variable \$([\w_]+) set to "(.*)"/ do |env_var, value|
  ENV[env_var] = value
end

Given /"(.*)" folder (is|is not) deleted/ do |folder, is_invoke|
  in_project_folder do
    @folder_deleted = if is_invoke == "is"
      FileUtils.rm_rf folder
      true
    else
      false
    end
  end
end

Given /^"([^\"]*)" folder (does|does not) exist$/ do |folder, does_invoke|
  in_project_folder do
    present = File.exists?(folder)
    @folder_exists = does_invoke == "does" ? present : !present
  end
end

Given /^"([^\"]*)" file (does|does not) exist$/ do |file, does_invoke|
  in_project_folder do
    present = File.exists?(file)
    puts "We are here #{present.to_s} #{file}"
    @file_exists = present if does_invoke == "does"
    @file_not_exists = !present if does_invoke == "does not"
  end
end

Given /^I am using a (broswer|editor|shell) to read "([^\"]*)"$/ do |device, source|
  @output_format = case
    when device == "broswer" then 'html'
    when device == "editor" then 'txt'
    when device == "shell" then 'cli'
    else nil
  end
end
