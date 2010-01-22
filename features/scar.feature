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
  | Interface                             | Interface                  |
  | Location                              | Location                   |
  | Public Address                        | Public Address             |
  | Request Status                        | Request Status             |
  | Snapshot                              | Snapshot                   |
  | Virtual Data Center                   | Virtual Data Center        |
#  | Requests to VNet Resources            | requests/VirtualNet        |
#  | Requests to Volume Resources          | requests/Volume            |
#  | Command Line Client                   | ./CommandLineInterface     |
  | Virtual Machine                       | Virtual Machine            |

