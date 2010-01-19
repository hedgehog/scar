#Feature: Development processes of SCAR itself (rake tasks)
#  In order to spend time on the specification, and not excessive time on maintenance processes
#  As a SCAR maintainer or contributor
#  I want to run rake tasks to maintain and release the gem
#
#  Scenario: Generate RubyGem
#    Given this project is active project folder
#    And "pkg" folder is deleted
#    When I invoke task "rake gem"
#    Then folder "pkg" is created
#    And file with name matching "pkg/*.gem" is created else you should run "rake manifest" to fix this
#    And gem spec key "rdoc_options" contains /--mainREADME.rdoc/
