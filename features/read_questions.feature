Feature: Questions Index
  As a site operator
  I wish for users to be able to view all questions
  In order to attract users to the site

  Scenario: Unregistered user
    Given I am an unregistered user
    And I visit the home page
    Then I should be able to view each post
    And I should not be able to comment on posts
    And I should not be able to vote on posts

  Scenario: Logged in user
    Given I am a registered user
    And I visit the home page
    Then I should be able to view each post
    And I should be able to comment on questions or answers
    And I should be able to vote on questions, answers, and comments

  @wip
  Scenario: Search
    Given I am a logged in user
    And I visit the home page
    Then I should be able to search the questions by tag name
    And I should be able to search the questions by content
    And I should be able to search the questions by 'Most popular'
    And the questions should be paginated
