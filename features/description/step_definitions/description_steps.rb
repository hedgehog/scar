require 'fakeweb'


Given /^I use the SCAR repository$/ do

#  in_project_folder do
#                      @repository_path = "#{Dir.getwd}" / "spec" / "factories" / "sca"
#                    end
#  @repository_path = "./spec/factories/sca"
#  puts @repository_path
#  responses = { "Home"=>"#{@repository_path}/Home.html",
#    "CommonBehaviors"=>"#{@repository_path}/CommonBehaviors.html",
#    "CloudAPISpecificationResourceModels"=>"#{@repository_path}/CloudAPISpecificationResourceModels.html"
#  }
#  @url_root = "http://kenai.com/projects/suncloudapis/pages"
#  FakeWeb.allow_net_connect = false # Make sure we don't go out into the open
#
#  responses.each do |key, value|
#    puts "Key: #{key}"
#    puts "Value: #{value}"
#    FakeWeb.register_uri(:get, "#{@url_root}/#{key}", :body => File.read(value))
#  end
  @url_root = "http://kenai.com/projects/suncloudapis/pages"
end

Then /^I should see the table$/ do |tbl|
  # table is a Cucumber::Ast::Table
  agent = WWW::Mechanize.new { |a| a.log = Logger.new("mech.log") }
  agent.user_agent_alias = 'Mac Safari'
  page = agent.get(@url+"/")
  html_table = page.search("/html/body/div/div/div[4]/div[2]/div/div[2]/div[2]")
  puts html_table.inspect
  #.map!{|r| r.map!{|c| c.gsub(/<.+?/,"")}}
end

