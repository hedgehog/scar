Feature: Local repository of Sun's Cloud API
  In order to quickly parse Sun's Cloud API descripiton
  As a API specification contributor
  I want to have a local copy of the API descripition pages

  Background:
  Given the Sun Cloud API pages on Kenai are not versioned
    And I am using a broswer to read "Sun's Cloud API"
    And I go to "Sun's Cloud API Home page"

  @repository
  Scenario Outline: Create a local repository of Sun's cloud API pages
    Given this project is active project folder
      And the "<file>" file does not exist in the repository
    When I scrape the API page "<link_text>"
    Then I should see the API file in the repository
      Examples:
      | file                                      | link_text             |
      | Home.html                                 | Home |
      | CommonBehaviors.html                      | Common Behaviors |
      | CloudAPISpecificationResourceModels.html  | Resource Models |
      | CloudAPIBackupRequests.html               | Requests to Backup Resources |
      | CloudAPIClusterRequests.html              | Requests to Cloud Resources |
      | CloudAPIClusterRequests.html              | Requests to Cluster Resources |
      | CloudAPIPublicAddressRequests.html        | Requests to Public Address Resources |
      | CloudAPISnapshotRequests.html             | Requests to Snapshot Resources |
      | CloudAPIVDCRequests.html                  | Requests to VDC Resources |
      | CloudAPIVMRequests.html                   | Requests to VM Resources |
      | CloudAPIVNetRequests.html                 | Requests to VNet Resources |
      | CloudAPIVolumeRequests.html               | Requests to Volume Resources |
      | CloudCommandClient.html                   | Command Line Client |

