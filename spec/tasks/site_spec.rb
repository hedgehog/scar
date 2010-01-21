# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "rake"

describe "site rake tasks" do
  before do
    @proj_dir=File.expand_path(File.dirname(__FILE__)+'/../../')
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require('site', @proj_dir/'tasks/')
    Rake::Task.define_task(:environment) # stubs out Rails environment which should already be loaded by Rspec
  end

  describe "rake site:clean" do
    before do
      @website_path = Pathname.new(Dir.pwd) / 'website'
      @task_name = "site:clean"
    end
    it "should have no prereq" do
      @rake[@task_name].prerequisites.should == ["set_pwd"]
    end
    it "should delete old output if it does exists" do
      output =  @website_path/'output'
      FileUtils.mkdir_p output if File.exist?(output)
      FileUtils.should_receive(:rm_r).and_return(nil)
      FileUtils.should_receive(:mkpath).and_return(nil)
      @rake[@task_name].invoke
    end   
    it "should not delete old output if it does not exist" do
      output =  @website_path/'output'
      FileUtils.rm_r output if File.exist?(output)
      FileUtils.should_not_receive(:rm_r).and_return(nil)
      FileUtils.should_receive(:mkpath).and_return(nil)
      @rake[@task_name].invoke
    end
  end
  describe "rake site:update" do
    before do
      @website_path = Pathname.new(Dir.pwd) / 'website'
      @task_name = "site:update"
    end
    it "should have no prereq" do
      @rake[@task_name].prerequisites.should == []
    end
    it "should run nanoc3 compile" do
      Kernel.stub!(:system)
      Kernel.should_receive(:system).with("nanoc3 co").and_return("")
      @rake[@task_name].invoke
    end
  end
  describe "rake site:rebuild" do
    before do
      @website_path = Pathname.new(Dir.pwd) / 'website'
      @task_name = "site:rebuild"
    end
    it "should have no prereq" do
      @rake[@task_name].prerequisites.should == ["clean","update"]
    end
    it "should run nanoc3 compile" do
      Kernel.stub!(:system)
      Kernel.should_receive(:system).with("nanoc3 co").and_return("")
      @rake[@task_name].invoke
    end
  end
#  describe "rake app:options:refresh" do
#    before do
#      @task_name = "app:options:refresh"
#      YAML.stub!(:load_file).and_return([])
#    end
#    it "should have 'environment' as a prereq" do
#      @rake[@task_name].prerequisites.should include("environment")
#    end
#
#    it "should load 'config/options.yml'" do
#      stub!(output)
#      stub!((output / @website_path / 'data'))
#      output.should_receive(:rmtree).and_return("")
#      (output / @website_path / 'data').should_receive(:mkpath).and_return("")
##      YAML.should_receive(:load_file).with("config/options.yml").and_return([])
#      @rake[@task_name].invoke
#    end
#    it "should create or update all records in the config file" do
#      YAML.should_receive(:load_file).with("config/options.yml").and_return([
#        { "name" => "option one", "value" => 10 },
#        { "name" => "option two", "value" => 20 }
#      ])
#      option_one = mock(Option, :null_object => true)
#      option_two = mock(Option, :null_object => true)
#
#      Option.should_receive(:find_or_initialize_by_name).with("option one").and_return(option_one)
#      Option.should_receive(:find_or_initialize_by_name).with("option two").and_return(option_two)
#
#      option_one.should_receive(:update_attribute).with("value", 10)
#      option_two.should_receive(:update_attribute).with("value", 20)
#      @rake[@task_name].invoke
#    end
#  end
end

