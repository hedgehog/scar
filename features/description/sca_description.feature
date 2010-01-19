@broken
Feature: Sun Cloud API Description
  In order to refactor Sun's Cloud API documentation
  As a API specification contributor
  I want to have complete description of the exisiting API specification

  Background:
    Given I am using a broswer to read "Sun's Cloud API Repository"
      And I use the SCAR repository

  Scenario:
    Given I am on "Home"
    When I follow "Common Behaviors"
    Then I should see the table
       | Header 	| Supported Values |	 Description of Use 	| Required |
       | head 	| value |	 description 	| req |



