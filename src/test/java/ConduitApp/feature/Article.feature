@newArticle
Feature: Create Article
  Background: Define base URL
    * url apiURL
    * def requestBodyPath = read('classpath:ConduitApp/Json/ArticleRequest.json')
    * def randomRequestData = Java.type('helpers.DataGenerator')
    * set  requestBodyPath.article.title =  randomRequestData.generateRandomBody().title
    * set requestBodyPath.article.description = randomRequestData.generateRandomBody().description
    * set requestBodyPath.article.description = randomRequestData.generateRandomBody().body



  Scenario: Post New Article

    Given path 'articles/'
    And request requestBodyPath
    When method Post
    Then status 201
    And match response.article.title == requestBodyPath.article.title


  Scenario: Create and verify and Delete Article

    Given path 'articles/'
    And request requestBodyPath
    When method Post
    Then status 201
    * def slug = response.article.slug


    Given params { limit:10,offset:0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == requestBodyPath.article.title



    Given path 'articles/',slug
    When method Delete
    Then status 204


    Given params { limit:10,offset:0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != requestBodyPath.article.title











