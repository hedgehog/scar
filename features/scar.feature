Feature: Sun Cloud API Reference
  In order to adopt Sun's Cloud API specification
  As a API specification contributor
  I want to access a dynamic, yet precise, API reference

  Background:
    Given this project is active project folder
      And the API pages are compiled
      And the nanoc3 auto-compiler web-server is running
      And I go to "nanoc's localhost Home page"
      # And the API pages have been generated by Yard version 0.5

  Scenario Outline: Explore the entry point page
    Given I am on "/"
    When I follow "<link_text>"
    Then I should be on <page_name>
#      And I should not see /File not found/

  Examples:
  | link_text                             | page_name                  |
  | Spec Home                             | Spec Home                  |
  | Common Behavior                       | Common Behavior            |
  | Resources                             | Resources                  |
  | Backup                                | Backup                     |
  | Cloud                                 | Cloud                      |
  | Cluster                               | Cluster                    |
#  | Requests to Location Resources        | requests/Location          |
  | Public Address                        | Public Address             |
  | Interface                             | Interface                  |
#  | Requests to Snapshot Resources        | requests/Snapshot          |
#  | Requests to VDC Resources             | requests/VirtualDataCenter |
#  | Requests to VM Resources              | requests/VirtualMachine    |
#  | Requests to VNet Resources            | requests/VirtualNet        |
#  | Requests to Volume Resources          | requests/Volume            |
#  | Command Line Client                   | ./CommandLineInterface     |

