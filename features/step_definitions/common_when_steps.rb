When /^I invoke "(.*)" generator with arguments "(.*)"$/ do |generator, arguments|
  @stdout = StringIO.new
  in_project_folder do
    if Object.const_defined?("APP_ROOT")
      APP_ROOT.replace(FileUtils.pwd)
    else
      APP_ROOT = FileUtils.pwd
    end
    run_generator(generator, arguments.split(' '), SOURCES, :stdout => @stdout)
  end
  File.open(File.join(@tmp_root, "generator.out"), "w") do |f|
    @stdout.rewind
    f << @stdout.read
  end
end

When /^I run executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "#{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I run project executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "ruby #{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I run local executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  executable = File.expand_path(File.join(File.dirname(__FILE__), "/../../bin", executable))
  in_project_folder do
    system "ruby #{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I invoke task "rake (.*)"/ do |task|
  @stdout = File.expand_path(File.join(@tmp_root, "tests.out"))
  in_project_folder do
    system "rake #{task} --trace > #{@stdout} 2> #{@stdout}"
  end
end

When /^I invoke "(.*)" generator with arguments "(.*)"$/ do |generator, arguments|
  @stdout = StringIO.new
  in_project_folder do
    if Object.const_defined?("APP_ROOT")
      APP_ROOT.replace(FileUtils.pwd)
    else
      APP_ROOT = FileUtils.pwd
    end
    run_generator(generator, arguments.split(' '), SOURCES, :stdout => @stdout)
  end
  File.open(File.join(@tmp_root, "generator.out"), "w") do |f|
    @stdout.rewind
    f << @stdout.read
  end
end

When /^I run executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "#{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I run project executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "ruby #{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I run local executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  executable = File.expand_path(File.join(File.dirname(__FILE__), "/../../bin", executable))
  in_project_folder do
    system "ruby #{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I invoke task "rake (.*)"/ do |task|
  @stdout = File.expand_path(File.join(@tmp_root, "tests.out"))
  in_project_folder do
    system "rake #{task} --trace > #{@stdout} 2> #{@stdout}"
  end
end

