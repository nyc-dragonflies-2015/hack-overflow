Feature: Login
  As a site operator
  I wish for users to be able to login
  In order to attract users to the site

  Scenario: Login
    Given I am a registered user
    And I visit the home page
    And I click 'Login'
    And I fill in the login form and submit
    Then I should be logged in to the site

  Scenario: Logout
    Given I am a logged in user
    And I visit the home page
    And I click 'Logout'
    Then I should be logged out of the site

  Scenario: Landing
    Given I am a user
    Then I would like to see some of the website content up front
    Then would like to signup for an account
    Then would like to login
    Then would like to sign out
    Then would like my account to be secure so only I can create content under my user name
