Feature: Signup
  As a site operator
  I wish for new users to be able to register with the site
  In order to attract users

  Scenario: Signup
    Given I am not a registered user
    And I visit the home page
    And I click 'Signup'
    And I fill in the form with the correct information
    Then I should be registered and logged in to the site

  Scenario: Delete Account
    Given I am a registered and logged in user
    And I click 'Edit Account'
    And I click 'Delete Account'
    Then my account should be deleted from the database

  Scenario: Edit Account
    Given I am a registered and logged in user
    And I click 'Edit Account'
    And I change my information
    Then my user information should be saved
