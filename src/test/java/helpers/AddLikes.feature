Feature: Add likes

  Background:
    * url apiURL

  Scenario: Add likes to feed
    Given path 'articles',slug,'favorite'
    And request {}
    When method Post
    Then status 200
    * def updatedLikes = response.articles.favoritesCount


