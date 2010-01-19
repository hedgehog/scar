Feature: Sun Cloud API Reference
  In order to adopt Sun's Cloud API specification
  As a API specification contributor
  I want to access a dynamic, yet precise, API reference

  Background:
    Given I am using a broswer to read "Sun Cloud API Reference"
      And the entry point is for API version nil
      # And the API pages have been generated by Yard version 0.5
      And the API pages are published

  Scenario Outline: Explore the entry point page
    Given I am on ""
    When I follow "<link_text>"
    Then I should be on <page_name>

  Examples:
  | link_text                             | page_name                  |
  | Common Behaviors                      | ./CommonBehaviors          |
  | Resource Models                       | ./ResourceModels           |
  | Requests to Backup Resources          | requests/Backup            |
  | Requests to Cloud Resources           | requests/Cloud             |
  | Requests to Cluster Resources         | requests/Cluster           |
  | Requests to Public Address Resources  | requests/PublicAddress     |
  | Requests to Snapshot Resources        | requests/Snapshot          |
  | Requests to VDC Resources             | requests/VirtualDataCenter |
  | Requests to VM Resources              | requests/VirtualMachine    |
  | Requests to VNet Resources            | requests/VirtualNet        |
  | Requests to Volume Resources          | requests/Volume            |
  | Command Line Client                   | ./CommandLineInterface     |
