$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
dir = Pathname(__FILE__).dirname.expand_path

require 'scar'

#require ''

#require 'machinist'
#require 'spec/factories'
require 'spec/expectations'
require 'webrat'
#require 'webrat/mechanize'
# require 'cucumber/webrat/table_locator' # Lets you do table.diff!
require 'nokogiri'
require 'mechanize'
WWW::Mechanize.html_parser = Nokogiri::HTML
#require 'spork'
require dir / '..' / 'step_definitions' / 'common_given_steps'
require dir / '..' / 'step_definitions' / 'common_when_steps'
require dir / '..' / 'step_definitions' / 'common_then_steps'
require dir / '..' / 'step_definitions' / 'web_steps'
require dir / 'common_helpers'

#Spork.prefork do
#  ENV["RAILS_ENV"] ||= "cucumber"
#  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
#
#  require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
#  require 'cucumber/rails/rspec'
#  require 'cucumber/rails/world'
#  require 'cucumber/rails/active_record'
#  require 'cucumber/web/tableish'
#
#  require 'webrat'
#  require 'webrat/core/matchers'
#  require 'cucumber/webrat/element_locator' # Deprecated in favor of #tableish - remove this line if you don't use #element_at or #table_at
#
#  Webrat.configure do |config|
#    config.mode = :mechanize
#    config.open_error_files = false # Set to true if you want error pages to pop up in the browser
#  end
#end
#
#Spork.each_run do
#  # If you set this to false, any error raised from within your app will bubble
#  # up to your step definition and out to cucumber unless you catch it somewhere
#  # on the way. You can make Rails rescue errors and render error pages on a
#  # per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
#  #
#  # If you set this to true, Rails will rescue all errors and render error
#  # pages, more or less in the same way your application would behave in the
#  # default production environment. It's not recommended to do this for all
#  # of your scenarios, as this makes it hard to discover errors in your application.
#  ActionController::Base.allow_rescue = false
#
#end

Before do
  @tmp_root = File.dirname(__FILE__) + "/../../tmp"
  @home_path = File.expand_path(File.join(@tmp_root, "home"))
  FileUtils.rm_rf   @tmp_root
  FileUtils.mkdir_p @home_path
  ENV['HOME'] = @home_path
end

Webrat.configure do |config|
  config.mode = :mechanize
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

class MechanizeWorld < Webrat::MechanizeAdapter
  include Webrat::Matchers
  include Webrat::Methods
  include Spec::Matchers
#  session = Webrat::MechanizeSession.new
#  session.extend(Webrat::Matchers)
#  session.extend(Webrat::HaveTagMatcher)
  # no idea why we need this but without it response_code is not always recognized
  #Webrat::Methods.delegate_to_session :response_code, :response_body
#  session
end

World(CommonHelpers)

World do
  MechanizeWorld.new
end
