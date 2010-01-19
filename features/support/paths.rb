module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /Sun's Cloud API Home page/
      @url_root = "http://kenai.com/projects/suncloudapis/pages"
      @url="#{@url_root}/Home"
    when /Home/
      @url="#{@url_root}/Home"
    when /Common Behaviors/
      @url="#{@url_root}/CommonBehaviors"
    when /Resource Models/
      "#{@url_root}/CloudAPISpecificationResourceModels"
    when /Requests to Backup Resources/
      "#{@url_root}/CloudAPIBackupRequests"
    when /Requests to Cloud Resources/
      "#{@url_root}/CloudAPIClusterRequests"
    when /Requests to Cluster Resources/
      "#{@url_root}/CloudAPIClusterRequests"
    when /Requests to Public Address Resources/
      "#{@url_root}/CloudAPIPublicAddressRequests"
    when /Requests to Snapshot Resources/
      "#{@url_root}/CloudAPISnapshotRequests"
    when /Requests to VDC Resources/
      "#{@url_root}/CloudAPIVDCRequests"
    when /Requests to VM Resources/
      "#{@url_root}/CloudAPIVMRequests"
    when /Requests to VNet Resources/
      "#{@url_root}/CloudAPIVNetRequests"
    when /Requests to Volume Resources/
      "#{@url_root}/CloudAPIVolumeRequests"
    when /Command Line Client/
      "#{@url_root}/CloudCommandClient"
    when /Sun's Cloud API Repository/
#      in_project_folder do
#        @url_root = "file://#{Dir.getwd}" / "spec" / "factories" / "sca" / "CommonBehaviors"
#        puts @url_root
#      end
#      @url_root
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)