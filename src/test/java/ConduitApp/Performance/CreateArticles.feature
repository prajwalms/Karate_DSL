@newArticle
Feature: Create Article
  Background: Define base URL
    * url apiURL
    * def requestBodyPath = read('classpath:ConduitApp/Json/ArticleRequest.json')
    * def randomRequestData = Java.type('helpers.DataGenerator')
    * set  requestBodyPath.article.title =  __gatling.Title
    * set requestBodyPath.article.description = __gatling.Description
    * set requestBodyPath.article.description = randomRequestData.generateRandomBody().body





  Scenario: Create and verify and Delete Article
#    * configure headers = {"Authorization": #('token'+__gatling.token)}
    Given path 'articles/'
    And request requestBodyPath
    And header karate-name = 'Title requested: '+__gatling.Title
    When method Post
    Then status 201
    * def slug = response.article.slug
#
#    * karate.pause(5000)
#
#    Given path 'articles/',slug
#    When method Delete
#    Then status 204











